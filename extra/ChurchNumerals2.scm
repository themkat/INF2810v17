;; For testing, så kan vi kanskje ønske ønske å laste inn definisjonene fra forrige oppgave
(load "Ex2.6_ChurchNumerals.scm")

;; Løsningsforslag for 1.42 fra ukeoppgave sidene
;; http://folk.uio.no/esbenss/inf2810/gruppelaererenes-side.html#Uke7
(define (compose f g)
  (lambda x (f (apply g x))))

;; Løsningsforslag for 1.43 fra ukeoppgave sidene: 
;; samme link som forrige
(define (repeated f n)
  (if (= 1 n)
      f
      (compose f (repeated f (- n 1)))))


;; Løsningsforslag for Church Numerals multiplikasjon:
;; Fra forrige oppgave husker vi at et Church nummer n tilsvarer
;; (f (f .... (f x)))   med f n ganger.
;; En mulig løsning blir da å anvende det første tallet like mange
;; ganger som dybden av det andre. Dybden kan vi f.eks finne slik
;;((two inc) 0) for Church nummeret two fra forrige oppgave.
;; Vi kan nå bruke repeated med fremgangsmåten over, noe som gir oss
(define (mult a b)
  (repeated a ((b inc) 0)))


;; Hvis noen kommer på en bedre (eller kulere!) måte, så send meg den gjerne! :)
