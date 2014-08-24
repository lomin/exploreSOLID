(import [sh [git cd]]
        [subprocess]
        [os]
        [os [pardir]]
        [os.path [abspath join]]
        [bottle [Bottle run template]])

(def chapters [{"chapter" "Die Beispielanwendung"
                "text" "<p>Start</p>"
                "branch" "classic_t1"}
               {"chapter" "DIP - Erster Schritt"
                "text" "<p>...</p>"
                "branch" "classic_t1_dip"}
               {"chapter" "Die neue Anforderung"
                "text" "<p>Neu!</p>"
                "branch" "classic_t2"}])

(defn add-whitespace [a b]
  (+ a " " b))

(defn gradle [&rest args]
  (setv path (.getcwd os))
  (cd (join path pardir))
  (apply .call [subprocess (+"./gradlew " (reduce add-whitespace args))] {"shell" true})
  (cd path))

(defn run-gradle []
  (gradle "clean" "test"))

(defn checkout [branch]
  (git "checkout" branch))

(def app (Bottle))

(with-decorator (.route app "/hans")
  (defn hans-route [] "Hello my Hans!"))

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
              <h3 class='masthead-brand'>Cover</h3>
              <ul class='nav masthead-nav'>
                <li class='active'><a href='#'>Home</a></li>
                <li><a href='#'>Features</a></li>
                <li><a href='#'>Contact</a></li>
              </ul>
            </div>
          </div>

          <div class='inner cover'>
            <h1 class='cover-heading'>{{chapter}}</h1>
            {{!text}}
            <p class='lead'>
              <a href='{{prev}}' class='btn btn-lg btn-default'>Previous Step</a>
              <a href='{{next}}' class='btn btn-lg btn-primary'>Next Step</a>
            </p>
          </div>

          <div class='mastfoot'>
            <div class='inner'>
              <p>Cover template for <a href='http://getbootstrap.com'>Bootstrap</a>, by <a href='https://twitter.com/mdo'>@mdo</a>.</p>
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


(defn get-chapter [index]
  (get chapters index))

(defn show-page [index]
  (setv vars (dict (get-chapter index)))
  (if (= index 0)
    (assoc vars "prev" "#")
    (assoc vars "prev" (+ "/" (str (dec index)))))
  (assoc vars "next" (+ "/" (str (inc index))))
  (apply template [base_tpl] vars))

(defn do-step [index]
  (git "checkout" (get (get-chapter index) "branch"))
  (gradle "clean" "idea" "iM" "test")
  (show-page index))


(with-decorator (.route app "/")
  (defn wizard-start [] (do-step 0)))


(with-decorator (.route app "/<step>")
  (defn wizard [step] (do-step (int step))))

(apply run [app] {"host" "localhost"
            "port" 8090
            "debug" false})
