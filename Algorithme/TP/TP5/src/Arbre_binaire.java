public class Arbre_binaire <T> {
    int Clef;
    T Element;
    Arbre_binaire <T> NextLeft;
    Arbre_binaire <T> NextRight;

    public Arbre_binaire(int Clef, T Element) {
        this.Clef = Clef;
        this.Element = Element;
        this.NextLeft = null;
        this.NextRight = null;
        
    }

    public Arbre_binaire(int Clef, T Element, Arbre_binaire <T> NextLeft, Arbre_binaire <T> NextRight) {
        this.Clef = Clef;
        this.Element = Element;
        this.NextLeft = NextLeft;
        this.NextRight = NextRight;
        
    }

    public T get() {
        return Element;
    }

    public T get(int K) {
        if (this.Clef == K) {
            return this.Element;
        } else if (K < this.Clef) {
            return this.NextLeft.get(K);
        } else {
            return this.NextRight.get(K);
        }
    }
    
    public void add(int Clef, T Element) {
        if (Clef < this.Clef) {
            if (this.NextLeft != null) {
                this.NextLeft.add(Clef, Element);
            } else {
                Arbre_binaire <T> toadd = new Arbre_binaire <T> (Clef, Element);
                this.NextLeft = toadd;
            }
        } else if (Clef > this.Clef) {
            if (this.NextRight != null) {
                this.NextRight.add(Clef, Element);
            } else {
                Arbre_binaire <T> toadd = new Arbre_binaire <T> (Clef, Element);
                this.NextRight = toadd;
            }
        } else {
            System.out.println("La clef existe déjà !");
        }
    }

    public String afficher() {
        return Clef + " : " + Element.toString();
    }

    public String toString() {
        if (this.NextRight != null) {
            if (this.NextLeft != null) {
                return this.afficher() + "\n" + NextLeft.toString() + "\n" + NextRight.toString();
            } else {
                return this.afficher() + "\n" + NextRight.toString();
            }
        } else {
            if (this.NextLeft != null) {
                return this.afficher() + "\n" + NextLeft.toString();
            } else {
                return this.afficher();
            }
        }
    }
}
