(import [sh [git]]
         [bottle [Bottle route run]])

(defn checkout [branch]
  (git "checkout" branch))

(apply run [(Bottle)] {"host" "localhost"
            "port" 8080
            "debug" false})
