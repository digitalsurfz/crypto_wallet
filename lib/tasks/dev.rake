namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") do  
        %x(rails db:drop:_unsafe)
      end

      show_spinner("Criando DB...") do
        %x(rails db:create)
      end

      show_spinner("Migrando DB...") do
      
        %x(rails db:migrate)
      end
      
        %x(rails dev:add_coins)
        %x(rails dev:add_mining_types)
      
    else
      puts "você não está em modo de desenvolvimento."
    end
  end

  desc "Cadastar as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
    coins = [
           {
              description: "Bitcoin",
              acronym: "BTC",
              url_image: "https://w7.pngwing.com/pngs/764/919/png-transparent-logo-bitcoin-graphics-dark-web-bmp-file-format-bitcoin-text-orange-logo.png"
           },
    
           {
              description: "Ethereum",
              acronym: "ETH",
              url_image: "https://www.pngitem.com/pimgs/m/124-1245793_ethereum-eth-icon-ethereum-png-transparent-png.png"
            },

           {
            description: "Dash",
                acronym: "DASH",
                url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png"
            }
        ]

coins.each do |coin|
    Coin.find_or_create_by!(coin)
    end
  end
end

desc "Cadastra os tipos de mineração"
task add_mining_types: :environment do
  show_spinner("Cadastrando tipos de mineração...") do
  mining_types = [
    {
      name: "Proof of Work",
      acronym: "PoW"
    },
    {
      name: "Proof of Stake",
      acronym: "PoS"
    },
    {
      name: "Proof of Capacity",
      acronym: "PoC"
    }
  ]

  mining_types.each do |mining_type|
    MiningType.find_or_create_by!(mining_type)
    end
  end 
end


  private
  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
   yield
   spinner.success("(#{msg_end})")

  end

end
