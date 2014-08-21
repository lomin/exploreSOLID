(import [sh [git cd]]
        [subprocess]
        [os]
        [os [pardir]]
        [os.path [abspath join]]
        [bottle [Bottle route run]])

(defn add-whitespace [a b]
  (+ a " " b))

(defn gradle [&rest args]
  (setv path (.getcwd os))
  (cd (join path pardir))
  (apply .call [subprocess (+"./gradlew " (reduce add-whitespace args))] {"shell" true})
  (cd path))

(gradle "clean" "test")

(defn checkout [branch]
  (git "checkout" branch))

(apply run [(Bottle)] {"host" "localhost"
            "port" 8080
            "debug" false})

