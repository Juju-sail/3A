package Graphe;

import java.util.Vector;

public class Sommet implements Comparable<Sommet>{

	int id;
	Vector<Sommet> voisins=new Vector<Sommet>();
	Vector<Double> poidss = new Vector<Double>();
	boolean flag=false;
	Double poidsCourant = null;
	Sommet voisinPrecedent = null;
	
	/**
	 * Constructeur utilisant un identifiant pour le sommet.
	 * @param id La valeur de l'identifiant du sommet.
	 */
	Sommet(int id) {
		this.id=id;
	}
	
	/**
	 * Ajoute un sommet dans la lsite des voisins du sommet.
	 * @param s Le sommet $agrave; ajouter.
	 */
	void addVoisin(Sommet s) {
		voisins.add(s);
		poidss.add(1.0);
	}
	
	void addVoisin(Sommet s, double poids) {
		voisins.add(s);
		poidss.add(poids);
	}
	
	/**
	 * V&eacute;rifie si un sommet est bien voisin du sommet de l'instence courante.
	 * @param s Le voisin potentiel.
	 * @return true or false.
	 */
	boolean isVoisin(Sommet s) {
		return voisins.contains(s);
	}
	
	double poidsVoisin(Sommet s) {
		for(int i = 0; i<voisins.size(); i++) {
			if(voisins.get(i)==s) return poidss.get(i);
		}
		return 0;
	}
	
	@Override
	public String toString() {
		String str=id+":(";
		for (int i=0;i<voisins.size()-1;i++)str+=voisins.get(i).id+",";
		return str+voisins.get(voisins.size()-1).id+")";
	}	
	
	public String outputVoisin() {
		String str = "";
		for(int i=0;i<this.voisins.size();i++) {
			if(this.id<= this.voisins.get(i).id)str += this.id+"--"+this.voisins.get(i).id+";\n";
		}
		return str;
	}
	public String outputVoisin(Graphe G) {
		String str = "";
		for(int i=0;i<this.voisins.size();i++) {
			if(this.id<= this.voisins.get(i).id) {
				if(G.isVoisin(this.id, this.voisins.get(i).id))str += this.id+"--"+this.voisins.get(i).id+"[color = red] ;\n";
				else str += this.id+"--"+this.voisins.get(i).id+";\n";
			}
		}
		return str;
	}
	
			
	public String outputVoisinRed() {
		String str = "";
		for(int i=0;i<this.voisins.size();i++) {
			if(this.id<= this.voisins.get(i).id)str += this.id+"--"+this.voisins.get(i).id+"[color = red];\n";
		}
		return str;
	}

	@Override
	public int compareTo(Sommet s) {
		if(this.poidsCourant>s.poidsCourant) return 1;
		else if(this.poidsCourant<s.poidsCourant) return -1;
		else return 0;
	}
}
