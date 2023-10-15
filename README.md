# Guia per desenvolupar el projecte:

# Routes
Cada pàgina està situada en una ruta. Les rutes les trobem a /config/routes.rb

Exemple de ruta:
> get "/create_post", to: "posts#create", as: :post

Podem observar:
* "/create_post" és la url del navegador.
* "to: "posts#create" redirigeix al controller "app/controllers/posts_controller.rb", en concret al mètode create.
* "as: :post" indica nom del model, en concret "app/model/post.rb"

# Controllers
A cada controlador tindrem les funcions on podrem guardar les variables que despres utilitzarem a les views.

Exemple de funció d'un controlador:
>def create
><ul style="list-style-type: none;">
><li>@pageTitle          = "Create Post"</li>
><li>@urlLabel           = "URL"
><li>@titleLabel         = "Title"
><li>@bodyLabel          = "Body"
><li>@submitButton       = "Create"
></ul>
>end
>

La funció create emmagatzema les variables que després podrà utilitzar la view mitjançant el posicionament d'una '@' davant del nom de la variable.

# Views
A la ruta "/app/views trobem diferents subdirectoris.
## Layouts
Entenc que seran components que embolicaran les nostres pàgines.
## Shared
Components que **compartirem** a diferents parts de l'aplicació. Per exemple botons o inputs de text.

Tindrem subcarpetes en funció de la seva utilitat, per exemple, a la carpeta "/app/views/shared/form" he posat tots els components que tenen a veure amb els formularis. Si un component l'utilitzarem a tot arreu no cal posar-ho en una subcarpeta.

El nom dels components serà "_nom_del_component.html.erb". Comença amb '\_' i les paraules de dins es separen amb '\_'.

Per utilitzar-los farem servir, per exemple:
> <%= render "shared/form/label" %>

Per insertar informació dins el component tenim dues opcions:
#### Via props:
>Component pare:
>> <%= render "shared/form/text_field", label: @urlLabel %\>
>

Al prop "label" se li assigna el valor @urlLabel, obtingut del controller corresponent. Tabé se li poden passar variables que no provinguin del controller o variables hardcoded.
> Component fill:
>><% if label.present? %>
>><ul style="list-style-type: none;">
>><li><%= render "shared/form/label" do %></li>
>><ul style="list-style-type: none;"><li><%= label %></li></ul>
>><li><% end %></li>
>></ul>
>><% end %>
>></ul>
>

Podem observar com al component fill utilitzem el valor del prop "label", tant comprovant si té valor (en el if) com passant-lo via yield al seu component fill.

#### Via yield:
>Component pare:
>> <%= render "shared/form/label" do %>
>><ul style="list-style-type: none;">
>><li>Patata</li>
>></ul>
>><% end %>
>
En aquest cas, se li passa al fill el contingut que està entre el tag que conté el "do" i el tag que conté el "end"

> Component fill:
>><label><% yield %></label>
>
Tot el contingut que el component pare ha passat es renderitza al lloc on es troba "<% yield %>".

## Altres
**Per cada model** que tinguem, tindrem una carpeta que es dirà com el model, pero **en plural**.

Allà emmagatzegarem les pàgines relacionades amb el controller corresponent (sense "\_" inicial).

# Models
Els models s'encarreguen de tot el que està relacionat amb la base de dades (consultes, insercions, **validacions**, relacions amb altres taules...).

Per crear un model, al terminal escriurem, per exemple:
> rails generate model Post title:string url:text body:text

En aquest cas el nom del model és "Post". Els noms de model han de ser **sempre en singular**.

Després del nom del model trobem els atributs, separats per espais. Els atributs estan formats per nomatribut:tipus. En aquest cas hem utilitzat text en comptes de string perquè string permet un màxim de 255 caràcters.

La comanda anterior crea una migració. Una migració declara els canvis que es faran a la base de dades.

També crea una classe "Post", situada a "/app/models/post.rb", que hereta de AplicationRecord.

Per executar la migració fem:
> rails db:migrate

Això crea la taula del model que hem creat a la base de dades.













# ...
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Test del primer commit en branch