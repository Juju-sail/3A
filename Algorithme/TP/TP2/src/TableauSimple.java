import java.lang.reflect.Array;
import java.util.Arrays;

public class TableauSimple {

	//Attributs
	int[] tab;
	
	//Constructeur
	public TableauSimple(int taille) {
		super();
		tab = new int[taille];
		for (int i=0; i<taille; i++) {
			tab[i] = (int)(100*Math.random());
		}
		
	}
	
	//toString
	public String toString() {
		String toReturn = "[";
		for(int i =0; i<tab.length-1; i++) {
			toReturn += tab[i] + ",";
		}
		toReturn += tab[tab.length-1];
		return "TableauSimple : " + toReturn + "]";
	}
	
	//Méthode max tab
	public static int maxTab(TableauSimple t) {
		int max = 0;
		for(int i=0; i<t.tab.length; i++) {
			if(max<=t.tab[i]) {
				max = t.tab[i];
			}
		}
		return max;
	}
	
	
	
	//Main
	public static void main(String[] args) {
		TableauSimple t = new TableauSimple(50);
		System.out.println("le maximum du taleau, \n " + t + "\nest : "+ maxTab(t));
	}
	
}