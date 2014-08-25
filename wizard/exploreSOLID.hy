(import [sh [git cd]]
        [subprocess]
        [os]
        [os [pardir]]
        [os.path [abspath join]]
        [bottle [Bottle run template]])

(def chapters [{"chapter" "Einleitung"
                "text" "<p>Um die SOLID-Prinzipien kennenzulernen werden wir die Entwicklung einer Beispielanwendung verfolgen.
                        Ihr beobachtet das Team FT-Adds dabei ein System nach SOLID zu entwicklen um Werbesprüche für Produkte anzuzeigen.
                        Dafür solltet ihr das 'exploreSOLID'-Projekt als Gradle-Projekt in IntelliJ importieren.</p>
                       <p>Wir werden das Beispiel und die Implementierung bewusst simpel halten.
                          Deshalb kann es gut sein, dass ihr überhaupt nicht einverstanden seid, wie FT-Adds Features umsetzt.
                          Macht euch dann bewusst, dass FT-Adds noch unsicher ist, wie man SOLID-Code erreicht.</p>
                       <p>
                          Damit der Umfang der Beispielanwendung nicht zu groß wird, werden wir uns auf das 'O', das 'I' und das 'D' aus SOLID konzentrieren.
                       </p>
                       <p>
                          Mit den zwei Buttons unten könnte ihr durch das Tutorial navigieren. Dadurch wird euer IntelliJ-Workspace eingerichtet.
                          Das kann ein paar Sekunden dauern. Sobald die Seite vollständig geladen wurde, steht euer Workspace bereit.
                       </p>
                       <p> 
                          Wenn ihr soweit seid, klickt auf 'Next Step' um zu sehen, wie FT-Adds die ersten Anforderungen an das neue System umsetzt.
                       </p>"
                "branch" "master"}
               {"chapter" "Das MVP"
                "text" "<p>Die erste Version soll folgende Feature beinhalten:</p>
                         <ol>
                          <li>Die Werbesprüche werden von den Marketing-Experten gepflegt und sind ab sofort im Produkt-Export des Teams 'Datenversorgung' enthalten.</li>
                          <li>Ein Werbespruch bezieht sich auf eine Variationen eines Produktes.</li>
                          <li>Werbesprüche sind immer nur für einen Tag gültig, werden aber mehrere Tage im Voraus gepflegt.</li>
                          <li>Werbesprüche werden als Templates gepflegt, in denen der Preis und das aktuelle Datum als Variable verwendet werden kann.</li>
                          <li>In der ersten Version reicht es aus, wenn der Werbespruch nach System.out ausgegen wird.</li>
                        </ol>
                       </p>
                       <p>
                          Wechselt jetzt in den Workspace um zu sehen wie FT-Adds das MVP umgesetzt hat.
                       </p>
                       </p>Es ist hilfreich, die vier Hauptklassen
                        <ul>
                          <li>Product</li>
                          <li>Variation</li>
                          <li>Claim</li>
                          <li>IntegrationTest</li>
                        </ul>
                       gleichzeitig in IntelliJ anzuzeigen.</p>"
                "branch" "classic_t1"}
               {"chapter" "Die neue Anforderung"
                "text" "<p>Neu!</p>"
                "branch" "classic_t2"}])

(defn index-chapters [l index]
  (if (not (empty? l))
    (do
      (assoc (first l) "index" index)
      (index-chapters (rest l) (inc index)))))

(index-chapters chapters 0)

(def base_tpl "<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>    <link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'>
    <link rel='stylesheet' href='//getbootstrap.com/examples/cover/cover.css'>
  </head>
   <body>

    <div class='site-wrapper'>

      <div class='site-wrapper-inner'>

        <div class='cover-container'>

          <div class='masthead clearfix'>
            <div class='inner'>
              <h3 class='masthead-brand'>Explore SOLID</h3>
              <ul class='nav masthead-nav'>
                <li><a href='/'>Start</a></li>
              </ul>
            </div>
          </div>

          <div class='inner cover'>
            <h1 class='cover-heading'>{{chapter}}</h1>
            <div style='text-align:left;'>
              {{!text}}
            </div>
            <p class='lead'>
              <a href='{{prev}}' class='btn btn-lg btn-default'>Previous Step</a>
              <a href='{{next}}' class='btn btn-lg btn-primary'>Next Step</a>
            </p>
          </div>

          <div class='mastfoot'>
            <div class='inner'>
              <p>SOLID Workshop for FT2</p>
            </div>
          </div>

        </div>

      </div>

    </div>    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
  </body>
</html>")

(def app (Bottle))

(defn add-whitespace [a b]
  (+ a " " b))

(defn gradle [&rest args]
  (setv path (.getcwd os))
  (cd (join path pardir))
  (apply .check_call [subprocess (+"./gradlew " (reduce add-whitespace args))] {"shell" true})
  (cd path))

(defn git-checkout [branch]
  (git "checkout" branch))

(defn create-branch-filter [branch]
  (fn [s] (= branch (get s "branch"))))

(defn find-current-step [branch]
  (setv step (nth (filter (create-branch-filter branch) chapters) 0))
  (if (nil? step)
    (nth chapters 0)
    step))
  
(defn find-step [index]
  (get (nth chapters index) "branch"))

(defn find-prev-step [index]
  (find-step (dec index)))

(defn find-next-step [index]
  (find-step (inc index)))

(defn show-page [branch]
  (setv current-step (find-current-step branch))
  (setv index (get current-step "index"))
  (setv vars (dict (find-current-step branch)))
  (if (= index 0)
    (assoc vars "prev" "#")
    (assoc vars "prev" (+ "/" (find-prev-step index))))
  (if (= index (- (len chapters) 1))
    (assoc vars "next" "#")
    (assoc vars "next" (+ "/" (find-next-step index))))
  (apply template [base_tpl] vars))

(defn do-step [branch]
  (git-checkout (get (find-current-step branch) "branch"))
  (gradle "clean" "idea" "iM")
  (show-page branch))

(with-decorator (.route app "/favicon.ico")
  (defn favicon [] nil))

(with-decorator (.route app "/<step>")
  (defn wizard [step] (do-step step)))

(with-decorator (.route app "/")
  (defn wizard-start [] (do-step "master")))


(if (= __name__"__main__")
  (apply run [app] {"host" "localhost"
            "port" 8090
            "debug" false}))
