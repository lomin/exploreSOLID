(import [sh [git cd]]
        [subprocess]
        [os]
        [os [pardir]]
        [os.path [abspath join]]
        [bottle [Bottle run template]])

(def chapters [{"chapter" "Einleitung"
                "text" "<p>Um die SOLID-Prinzipien kennenzulernen werden wir die Entwicklung einer Beispielanwendung verfolgen.
                        Ihr beobachtet das Team FT-Ads dabei ein System nach SOLID zu entwicklen um Werbesprüche für Produkte anzuzeigen.
                        Dafür solltet ihr das 'exploreSOLID'-Projekt als Gradle-Projekt in IntelliJ importieren.</p>
                       <p>Wir werden das Beispiel und die Implementierung bewusst simpel halten.
                          Deshalb kann es gut sein, dass ihr überhaupt nicht einverstanden seid, wie FT-Ads Features umsetzt.
                          Macht euch dann bewusst, dass FT-Ads noch unsicher ist, wie man SOLID-Code erreicht.</p>
                       <p>
                          Damit der Umfang der Beispielanwendung nicht zu groß wird, werden wir uns auf das 'O', das 'I' und das 'D' aus SOLID konzentrieren.
                       </p>
                       <p>
                          Mit den zwei Buttons unten könnte ihr durch das Tutorial navigieren. Dadurch wird euer IntelliJ-Workspace eingerichtet.
                          Das kann ein paar Sekunden dauern. Sobald die Seite vollständig geladen wurde, steht euer Workspace bereit.
                       </p>
                       <p> 
                          Wenn ihr soweit seid, klickt auf 'Next Step' um zu sehen, wie FT-Ads die ersten Anforderungen an das neue System umsetzt.
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
                          Wechselt jetzt in den Workspace um zu sehen wie FT-Ads das MVP umgesetzt hat.
                       </p>
                       <p>Es ist hilfreich, die vier Hauptklassen
                        <ul>
                          <li>Product</li>
                          <li>Variation</li>
                          <li>Claim</li>
                          <li>IntegrationTest</li>
                        </ul>
                       gleichzeitig in IntelliJ anzuzeigen.</p>
                       <h2>Frage: Ist die Umsetzung SOLID? Wenn nein, welches SOLID-Prinzip hat FT-Ads bei der Umsetzung verletzt?</h2>"
                "branch" "classic_t1"}
               {"chapter" "Der Ripple-Effect"
                "text" "<p>FT-Ads hat das DI-Prinzip verletzt. Die Klasse Product ist Compile-abhängig von Variation und Claim.
                           Aus der Traum vom <a style='color:red;' href='http://martinfowler.com/bliki/BoundedContext.html'>Bounded Context</a>.
                           Eine weitere Konsequenz ist der Ripple-Effekt (dessen Auswirkungen auch als Veränderungsschockwellen bezeichnet werden).</p>
                        <p>Um diesen Effekt zu beobachten muss man sich nur anschauen, welche Stellen angepasst werden müssen,
                           um den Markennamen des Prouktes in den Werbesprüchen zu verwenden.</p>
                        <p>Der nächste Schritt ist eigentlich einer zurück. FT-Ads löst zuerst die Verletzung des DI-Prinzips auf, bevor es eine neue Anforderung umsetzt."
                "branch" "classic_t2"}
               {
                "chapter" "Abhängig - aber richtig!"
                "text" "<p>Nun sind die Abhängigkeiten der Klassen auf Compile-Ebene korrekt geordnet.</p>
                        <h2>Frage: Ist nun alles gut?</h2>
                        <p>Die Frage beantwortet sich, wenn FT2-Adds im nächsten Schritt versucht das neue Feature 'Marke im Werbespruch' umzusetzen.</p>"
                "branch" "classic_t1_dip"}
               {
                "chapter" "Implizite Abhängigkeiten"
                "text" "<p>Nun sind die Abhängigkeiten der Klassen auf Compile-Ebene korrekt geordnet.</p>
                        <h2>Frage: Ist nun alles gut?</h2>
                        <p>Die Frage beantwortet sich, wenn FT2-Adds im nächsten Schritt versucht das neue Feature 'Marke im Werbespruch' umzusetzen.</p>"
                "branch" "classic_t2_dip"}
               {
                "chapter" "Naive OCP"
                "text" "<p>Nun hat FT-Ads den Holzhammer herausgeholt und können nun alles was im Produkt oder an der Variation jetzt oder in Zukunft gespeichert wird im Werbespruch verwenden.
                           Claim ist also nun offen für Erweiterungen ('open') und Product und Variation sind geschlossen gegenüber Veränderungen,
                           die sich nur aus Anforderungen an das Modul Claim ergeben.</p>
                       <h2>Frage: Genügt die Umsetzung damit dem OC-Prinzip?</h2>"
                "branch" "classic_t1_dip_ocp"}
               {
                "chapter" "Append only"
                "text" "<p>FT-Ads hat es nun eine stabile Abstraktion geschaffen, mit der sie die meisten möglichen zukünftigen Anforderungen nur durch das Hinzufügen von Code umsetzen können,
                           ohne dabei bestehenden Code ändern zu müssen. Natürlich sind auch Anforderungen denkbar, welche sich nicht durch eine ReplacingStrategy lösen lassen.
                           Das ist aber auch ok, weil wir nicht open für alle denkbaren Anforderungen sein können und auch nicht wollen, um kein hyper-generisches System pflegen zu müssen.
                           Um die richtigen Abstraktionen zu finden, ist es deshalb sehr vorteilhaft sich mit dem Product Owner über mögliche Richtungen abzustimmen,
                           in die sich das System entwickeln kann.</p>
                        <h2>Frage: Ist der Code endlich SOLID?</h2>
                        <p>Nein. Wer findet den Werwolf?</p>"
                "branch" "classic_t1_dip_ocp_add_only"}
               {
                "chapter" "Das Interface Segregation Principle"
                "text" "<p>FT-Ads hat den Bug gefunden und durch die Erfüllung des Interface Segregation Principle sichergestellt, dass diese Art von Fehler nicht mehr auftreten kann.
                           Zusätzlich wurde die Kopplung zum Produkt verringert, so dass ein Claim nun mit beliebigeb Implementation von 'ReadOnlyProduct' arbeiten kann.</p>
                        <p>Ironischerweise ist die Anwendung nun weniger 'open/closed' hinsichtlich des Renderings eines Werbespruchs als zuvor.
                           Sollen weitere Attribute einer Variation im Werbespruch aufgenommen werden (beispielsweise die Farbe), kann FT-Ads nicht mehr das Interface Buyable verwenden.</p>
                        <p>
                           Sie könnten ähnlich wie beim Produkt mit einer ReadOnlyVariation arbeiten, die alle Attribute mit lesendem Zugriff zur Verfügung stellt. Wie auch beim
                           beim ReadOnlyProduct ist jedoch nur eine Frage der Zeit, bis man mit dieser Variante erneut gegen das ISP verstößt
                           ('Many client specific interfaces are better than one general purpose interface'). Auch wenn durch ein ReadOnly-Interface keine Seiten-Effekte autreten können,
                           so schafft es doch unnötige Kopplung, reduziert damit die Wiederverwendung in einem anderen Kontext und vergrößert den <a style='color:red;' href='http://martinfowler.com/bliki/BoundedContext.html'>Bounded Context</a>.
                       </p>
                       <p>
                           Die andere Variante wäre, dass die Klasse Variation ein Interface implementiert, das im Modul Variation liegt, aber nur die Attribute veröffentlicht, welche für
                           die Replacing-Strategies relevant sind. Diese Variante würde das IS-Prinzip erfüllen. Das DI-Prinzip wäre dafür verletzt - zwar nicht auf Compile-Ebene,
                           aber immer wenn eine neue Information der Variation im Werbespruch benötigt wird, müsste man das Modul Variation anpassen (um das spezifische Interface zu ändern).
                           Das Modul Variation wäre somit implizit abhängig von Claim-Modul.
                       </p>
                       <h3>Food For Thought: Wie sehe die Anwendung komplett nach SOLID aus? Und will man das eigentlich?</h3>"
                "branch" "classic_t1_dip_ocp_add_only_isp"}])

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
  (git "stash")
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
