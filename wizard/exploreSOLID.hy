(import [sh [git cd]]
        [subprocess]
        [os]
        [os [pardir]]
        [os.path [abspath join]]
        [bottle [Bottle run template]])

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

(with-decorator (.route app "/")
  (defn wizard-start [] (apply template ["hello_template"] {"name" "test"})))

(apply run [app] {"host" "localhost"
            "port" 8090
            "debug" false})
