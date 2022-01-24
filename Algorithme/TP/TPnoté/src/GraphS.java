import java.util.Vector;

public class GraphS implements Graph{

	//Attributs
	Vector<Sommet> sommet = new Vector<Sommet>();
	int taille;
	
	//Constructeurs
	public GraphS(int taille) {
		this.taille = taille;
		for(int position=0; position<taille;position++) {
			sommet.add(new Sommet(position));
		}
	}
	
	public GraphS() {
		super();
	}
	
	//toString
	public String toString() {
		String toReturn="";
		for (int i=0;i<taille;i++) toReturn+=sommet.get(i)+" ";
		return toReturn;
	}
	
	//M�thode ajout arrete
	public void addArete(int i, int j) {
		sommet.get(i).addVoisin(sommet.get(j));
		sommet.get(j).addVoisin(sommet.get(i));
	}
	
	
	public boolean isVoisin(int i, int j) {
		// TODO Auto-generated method stub
		return false;
	}
	public Matrice getAdj() {
		// TODO Auto-generated method stub
		return null;
	}
	public int distanceSommets(int a, int b) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	

}
