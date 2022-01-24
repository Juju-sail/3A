import java.util.ArrayList;

public class Listes<T> { //T pour pouvoir faire des listes de nimporte quel type d'elements
	//Attributs
	T element;
	Listes<T> pointeur;
	//Constructeur
	public Listes(T element) {
		this.element=element;
		this.pointeur = pointeur;
	}
	public Listes(T element, Listes<T> pointeur) {
		this.element = element;
		this.pointeur = pointeur;
	}
	//get et sets
	public T getElement() {
		return element;
	}
	public void setElement(T element) {
		this.element = element;
	}
	public Listes<T> getPointeur() {
		return pointeur;
	}
	public void setPointeur(Listes<T> pointeur) {
		this.pointeur = pointeur;
	}
	//toString
	public String toString() {
		if(pointeur==null) return element.toString();
		else {
			return element.toString() + "," + pointeur.toString();
		}
		
	}
	//Méthode ajout element
	public void add(T element) {
		Listes<T> L3 = new Listes<T>(element, this.pointeur);
		this.pointeur = L3;
	}
	
	public void addFin(T t) {
		if(pointeur!=null) pointeur.addFin(t);
		else add(t);
	}
	
	//main
	public static void main(String[] args) {
		Listes<Integer> maListe2 = new Listes<Integer>(10);
		Listes<Integer> maListe = new Listes<Integer>(3, maListe2);
		System.out.println(maListe);
		maListe.add(7);
		System.out.println(maListe);
		maListe.addFin(27);
		System.out.println(maListe);
	}
	
	
	
	
}
