# Movie App iOS
![](movies.gif)

### Check list

- [x] API The Movie Database
- [x] MVVM
- [x] Gêneros, filmes e detalhe do filme
- [x] Swift
- [x] Layout baseado no Movies do App iTunes Store
- [x] Guideline Human Interface
- [x] Alamofire
- [x] Teste unitário
- [x] Rx
- [x] Targets
- [x] Localizable Strings
- [x] ViewCode


### Localizable.strings
O app foi desenvolvido para duas línguas, Inglês e Português, através do uso de lozalizable strings. Apesar disso, as requisições estão sendo feitas no default da API, por isso as informações estão em inglês. 

### Testes unitários
Os testes unitários foram feitos para testar algumas funções principalmente relacionadas ao *Movie*.

![](https://i.ibb.co/F8j9Fpp/Captura-de-Tela-2020-02-02-a-s-20-06-08.png)

### Rx
Usei Rx principalmente em requisições e alguns controles da ViewController.

### ViewCode
Projeto inteiramente feito em ViewCode

### Dark Mode
O app foi feito pensando no Dark Mode on/off

![](https://i.ibb.co/Xzp7Mss/New-Project.png)

### Targets
O app possui 2 Targets, sendo que um deles é uma versão kids. A versão kids possui um outro ícone, além de não possuir filmes adultos. Essa feature é controlada através do target pela setting *Activate Compilation Conditions*  de cada target.

![](https://i.ibb.co/JjKTh1p/Simulator-Screen-Shot-i-Phone-11-2020-02-02-at-18-21-09.png)

### TODO
- Corrigir alguns bugs
- Testes com Quick/Nimble
- Parallax
- Paginação na lista
- Opção de língua no app
