;; Oppgave 2.6 fra SICP

;; Debug-hjelper
(define (inc x) (+ 1 x))


;; Fra oppgaveteksten har vi følgende definisjoner:
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))


;; Vi observerer raskt at vi kan oversette Church Numerals til tall (nyttig hvis man
;;  er mer praktisk enn teoretisk anlagt). Dette kan vi gjøre med debug-prosedyren over, slik:
((zero inc) 0)
;; => 0


;; Oppgave: Definer one og two
;; Vi set fra både zero og add-1 at prosedyrene våre vil være på formen
;; (lambda (f) (lambda (x) <body>))
;; Vi ser først på hvordan one kan løses. Det første vi kan gjøre er å bruke hintet
;; fra oppgaveteksten, hva resultatet av add-1 anvendt på zero vil bli. Vi setter inn
;; zero som input n i add-1 og får:
;; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;; Bruker deretter substitusjonsmodellen til å redusere dette.
;; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;; (lambda (f) (lambda (x) (f x)))
;; Vi har nå funnet en prosedyrekropp for one, og kan dermed definere den slik:
(define one
  (lambda (f) (lambda (x) (f x))))

;; Gjør det samme, men med one som input til add-1 istedenfor zero. Dette gir oss two:
(define two
  (lambda (f) (lambda (x) (f (f x)))))


;; Noen testkall for de som fortsatt synes det er uklart:
((one inc) 0)
;; => 1
((two inc) 0)
;; => 2



;; Oppgave: Definer en generell plus-prosedyre som tar imot to church nummere
;; Denne er mer tricky å forklare (og forklaringen min er nok langt ifra perfekt).
;; Vi legger merke til at hvert "tall" er en anvendelse av en prosedyre f n antall
;;  ganger (hvor n er Church nummeret vårt, f.eks 0, 1 og 2 definert over).
;; Vi ønsker f.eks at (plus one two) skal bli en prosedyren
;; (lambda (f) (lambda (x) (f (f (f x)))))
;; Hvordan gjør vi dette? Observer at hvis vi setter inn two sin prosedyrekropp som x i one
;; så vil vi få det riktige svaret. For å få f(f(x)) som uttrykk (og ikke som en prosedyre
;;  som returnerer en ny prosedyre), kan vi bruke ((two f) x)  (hvor f og x er input til plus).
;; For å anvende one på resultatet av dette trenger vi kun å ta imot en x i resultatprosedyren.
;; Dette gir oss (one f), og det fulle uttrykket ((one f) ((two f) x)). Vi kan generalisere dette
;; til alle tall (ingen endringer trengs!), noe som gir:
(define (plus a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))


;; Utrolig kult, ikke sant? :)
