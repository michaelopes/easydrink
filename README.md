
<img src="https://user-images.githubusercontent.com/10121156/104236877-95e4e680-542d-11eb-93f8-a632961deaec.png" data-canonical-src="https://user-images.githubusercontent.com/10121156/104236877-95e4e680-542d-11eb-93f8-a632961deaec.png" width="200" />

## Desenvolvedor
**Nome:** Michael Lopes<br/>
**Facebook:** https://facebook.com/michael.s.lopes/ <br/>
**LinkedIn:** https://linkedin.com/in/michaelslopes/ <br/>

## Download do APK demo
https://github.com/michaelopes/easydrink/blob/master/demo/app.apk?raw=true

## Imagens
![Images](https://user-images.githubusercontent.com/10121156/104336345-aeefa500-54ca-11eb-8c18-ebe9db5b62c2.png)

## Vídeo demostrativo


https://user-images.githubusercontent.com/10121156/104368557-9eebbb80-54f2-11eb-9cef-441375e55bc6.mp4


## Arquitetura
A arquitetura escolhida para esse projeto é a Modular. Esta arquitetura é focada no desacoplamento de código. Sua origem é com base nos projetos de Angular 7 ou superior. O responsáveis por criar e estruturar essa arquitetura para o flutter é a equipe brasileira do Flutterando com o projeto **Modular** https://github.com/Flutterando/modular. A estrutura modular consiste em módulos desacoplados e independentes que representarão as funcionalidades da aplicação. Cada módulo está localizado em seu próprio diretório e controla suas próprias dependências, rotas, páginas, widgets e lógica de negócios. Consequentemente, você pode facilmente desanexar um módulo de seu projeto e usá-lo onde quiser¹. Com isso ganhando agilidade no desenvolvimento organizado do projeto

Para gerência de estado global a escolha foi para o Mobx com o pacote **flutter_mobx** https://pub.dev/packages/flutter_mobx. Esse package tem uma integração perfeita com a estrutura modular, reduzindo ainda mais falhas de desenvolvimento 

¹ **Fonte:** *Fluterando, equipe Modular https://github.com/Flutterando/modular/tree/master/flutter_modular#what-is-flutter-modular*

## Repository
São objetos responsáveis por executarem conexões com APIs ou LocalStorage e devem ser injetadas nos controllers ou stores. Não é bom que um controller execute uma regra que acesse a internet ou componente interno como um banco de dados, para isso use Repository.

## Entendendo os módulos
Os módulos desse projeto estão seguindo os padrões de organização dispostos pela arquitetura Modular. Cada módulo fica dentro de uma pasta com o nome do módulo ex: **home**, dentro dessa pasta terá três arquivos o controller (Controlador), page (Página/UI) e module. Nomeados da seguinte forma:
- home_controller.dart
- home_page_dart
- home_module.dart

 ### Controller 
O controlador neste caso terá toda a regra de negócio referente ao seu módulo específico, que por sua vez também é uma implementação de uma **Store do Mobx** para o gerenciamento integrado e global do estado do módulo *home*.

### Page
A page é responsável pela interface do app onde será implementado todos os widgets para dar vida a UI. Toda page nesse neste modelo deve ser um statefull herdada de ModularState como no exemplo: **ModularState<HomePage, HomeController>**
isso fará com que a page tenha acesso ao seu controlador através da variável **controller**.

### Module
Module é a implementação do módulo em sí, através desse arquivo o package modular saberá como se comportar em relação ao módulo home. Para a construção do módulo a classe do mesmo deve herdar da classe ChildModule, com isso será obrigatório a implantação dos itens abaixo:
- **List<Bind> get binds => [];**
- **List<ModularRouter> get routers => [];**
- **static Inject get to => Inject<T>.of();**
   
**Ficando da seguinte forma no caso do módulo home:** 
   
```dart
class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => HomeController(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => HomePage(),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
```

## Estrutura do projeto
- **app** | *Pasta que contém todo o projeto do app*
   - **app_bootstrap.dart** | *Wrapper inícial do app. Onde inicia a view geral do app*
   - **app_controller.dart** | *Esse é controllador global do app já com a implementação do Mobx*
   - **app_module.dart** | *Implementação da estrutura modular aqui fica todos os binds globais do app*
   - **core**
     - **api**
       - **api.dart** | *Classe customizada com herança de DioForNative para requisições a API http*
     - **const**
       - **app_assets.dart** | *Classe de constantes com todos os caminhos de arquivos de imagem, icones e sons utilizados no app*
       - **app_colors.dart** | *Classe de constantes com todas as cores customizadas que o app utiliza ou virá a utilizar*
       - **app_config.dart** | *Classe de constantes com configurações gerais do app ex: apiBaseUrl a url base para requisições na API*
       - **app_routes.dart** | *Classe de constantes com nome de rotas que é utilizada nas NamedRoutes da arquitetura modular8
     - **local_storage**
       - **local_storage.dart** | *Classe wrapper para facilitar a integração com o LocaStorage com a implementação do SharedPreferences*
     - **localization**
       - **localization_delegate.dart** | *Classe responsável por gerenciar e identificar a linguagem do sistema operacional e replicar para o app*
       - **localization.dart** | *Classe responsável por carregar o arquivo json de linguagem da pasta **lang** no root do projeto de acordo com o Delegate acima*
       - **translate.dart** | *Classe responsável por trazer o texto da linguagem baseado em uma key separadas por ponto ex: menu.aboutThisApp*
     - **response**
       - **response_default.dart** | *Wrapper responsavel pelos retornos de API*
       - **response_builder.dart**  | *Classe que construirá o retorno de acordo com a responsa obtitida via API ex: ResponseBuilder.success()*
       - **response_status.dart** | *Enum para identificação do tipo de retorno da API ex: enum ResponseStatus { rsSuccess, rsFailed }*
     - **theme**
       - **app_theme_factory.dart** | *Classe responsável pelo gerenciamentos dos temas do app pondendo ser Dark ou Light*
       - **app_theme_dark.dart** | *Tema Dark **NÃO IMPLEMENTADO** responsavel por tornar o tema do app para padrão escuro* 
       - **app_theme_light.dart** | *Tema Light onde é informado os padrões de cores e fonts para o app no tema claro*
     - **util**
       - **list_callbacks.dart** | *Tratar as exeções nas listas ex: quando a API não retornar dados chama-se ListCallbacks.noItemsFoundIndicator*
       - **star_rating.dart** | *Abre o pop-up para sistema de avaliação, tando do Drink quanto do App*
   - **interfaces**
     - **app_theme_interface.dart** | *Assinatura dos métodos para criação de um novo tema no app*
     - **drink_repository_interface.dart** | *Assinatura dos métodos para criar um repositório para chamadas a API*
     - **favorite_repository_interface.dart** | *Assinatura dos métodos para criar repositório para chamada dos favoritos em LocalStorage* 
     - **response_error_handler_interface.dart** | *Assinatura de classe para criar um "interceptador de erros" para efetuar um tratamento de erro específico*
   - **models**
     - **category.dart** | *Modelo de Categorias do retorno da API que utilizado na lista do módulo Home com os endpoints categories, glasses,ingredients, alcoholic*
     - **drink.dart** | *Modelo de Drinks do retorno da API que utilizado na lista do módulo Search e Favorite com os endpoints /filter.php? e /search.php?s=term*
   - **modules** | *Todos módulos do app. Explicação de como é estruturado um módulo no capítulo **Entendendo os módulos** acima*
     - **drink_detail**
     - **favorite**
     - **home**
     - **menu**
     - **search**
     - **tabs**
   - **repositories**
     - **drink_repository.dart** | *Repositório responsavel pelo acesso a API de serviço onde trará as listagem das categorias da **Busca rápida** assim como os Drinks em sí*
     - **favorite_repository.dart** | *Repositório responsável por acesso ao LocalStorage de favoritos, inserção e listagens dos mesmos*
   - **widgets**
     - **app_progress_dialog.dart** | *Wigdet de para mensagem de Espera (loading) é chamado quando é feito uma operação que leva um tempo como acesso a API*
     - **drink_card.dart** | *Card de drink que são mostrados no módulo de Pesquisa (search) assim como do Favoritos (favorite)*
     
## Perguntas e respostas
- Como chamo uma rota de navegação com o modular?
  - R: Modular.to.pushNamed(AppRouters.tabs)
- Como fecho uma página com o modular?
  - R: Modular.to.pop(`aqui o nome da rota **opcional**`)
- Como passo parametro para outra rota?
   - R: Modular.to.pushNamed(AppRouters.tabs, arguments: `valor do paramentro aqui podendo ser um objeto` )
- De onde vem os textos que aparecem para o usuário ex: texto "Busca rápida"?
   - R: Todos os textos do app ficam em arquivos json localizados na pasta /lang no root do projeto para cada linguagem que o app suportar terá um arquivo da linguagem específica ex: pt.json para o português e en.json para o inglês assim sucessivamente. Para acessar os atributos desse json preciso usar a classe Translate como no exemplo: **Translate(context).text("fastFilters")** assim retornando valor do atributo para linguagem do sistema operacinal, caso a linguagem não seja suportada sempre retornará o inglês.


## Packages utilizados
Os pacotes utilizados nesse projeto tem como premissa ganhar agilidade no desenvolvimento, focando mais na regra de negócio e na contrução de uma UI mais bonita e elegante.

- **flutter_localizations** | *Para realizar a integração da linguagem do sistema operacional para o App*
- **flutter_modular** | *Para trabalhar com o padrão de desenvolvimento Modular*
- **mobx** | *Para gerenciamento de estado de maneira globalizada e integrada com a Arquiterura modular*
- **flutter_mobx** | *Para realizar a integração entre Mobx e o Flutter/Dart*
- **shared_preferences** | *Para acesso ao LocalStorage com um sistema de chave e valor mais simples e eficiente*
- **flutter_icons** | *Biblioteca com uma gama de icones maior que a nativa disposta no flutter*
- **google_fonts**| *Integrar fontes do google com o thema global do app com mais facilidade sem necessidade de fazer downloads das fontes*
- **dio** | *Biblioteca de acesso a API rest, soap ou requisições http no geral*
- **toast** | *Para mostar mensagem em formato de toast "Mensagem preta com letras brancas em baixo do app"*
- **infinite_scroll_pagination** | *Para facilitar a contrução de ListViews, com vários "pre-sets" como paginação integrada, load de carregamento entre outros*
- **flutter_staggered_animations** | *Para realizar animações em itens de dos ListViews no app*
- **cached_network_image** | *Utilizado para facilitar o cache de imagem assim como loading e tratamento de erros em caso de falhas*
- **animated_bottom_navigation_bar** | *Para criar a barra de navegação do bottom do app com animação assim como uma boa estilização e mais elegante*
- **carousel_slider** | *Utilizado no módulo home a área de Buscas rápidas para mostrar de forma mais elegante as opções de filtro*
- **progress_dialog** | *Utilizado na construção do widget global AppProgressDialog para loadings de carregamento*
- **modal_bottom_sheet** | *Para mostrar as opções de filtros no módulo de pesquisa (**search**)*
- **rating_dialog** | *Pop-up usado na avaliação de drinks e do app*
- **sliding_up_panel** | *Para mostrar os ingredientes de modo de prepato no módulo de Detalhamento de drink (**drink_detail**)*
- **translator** | *Para realizar as traduções dos textos no módulo de Detalhamento de drink (**drink_detail**)*
- **share** | *Para facilitar o comparilhamento dos drinks no módulo de Detalhamento de drink (**drink_detail**)*
- **package_info** | *Utilizado para mostrar as informações do app no módulo de menu no item **Sobre o app***

## Futuras implementações
- [ ] Tradução para espanhol e alemão
- [ ] Implementação de tema escuro

## Como rodar esse projeto?
 - Baixe e instale o a versão mais recente do **Android Studio** https://developer.android.com/studio
 - Baixe e descopacte o flutter sdk conforme as instruções:
   1. Baixe o SDK (https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.22.3-stable.zip) do Flutter e extraia-o.
   2. Extraia o arquivo baixado e coloque a pasta “flutter” no diretório desejado, ex.: C:\src\flutter. A documentação desaconselha instalar o Flutter em um         diretório como C:\Program Files\ para evitar problemas com falta de permissão.
   3. Adicione o Flutter à variável PATH do sistema. Para tal, copie o caminho até o diretório \bin, existente na pasta “flutter”. No Windows Explorer, clique com o botão direito em “Este computador” e acesse a opção “Propriedades”. Em seguida vá em “Configurações avançadas do sistema” → “Variáveis de ambiente”. No text field “Variáveis de usuário”, clique na variável PATH → “Novo”, e cole o caminho para o diretório \bin.
   4. Baixe o Visual Studio code baixe as extensões Flutter, Dart, flutter_mobx para abrir o projeto
   5. Baixe esse repositório em uma pasta em seu computador 
   6. Abra o terminal vá para dentro da pasta do projeto e execute **flutter pub get** espere instalar os packages e depois execute **flutter run** no seu terminal _Pluge um device na sua máquina para ser mais rápido_

