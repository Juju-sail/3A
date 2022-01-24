import java.util.Arrays;

public class Tris {

		//Attributs
		int[] tab;
		String nomTab;
		int taille;
		int nbMax;
		
		//Constructeur
		public Tris(String nomTab, int taille, int nbMax) {
			super();
			tab = new int[taille];
			for (int i=0; i<taille; i++) {
				tab[i] = (int)(nbMax*Math.random());
			}
			this.nomTab = nomTab;
			this.taille = taille;
			this.nbMax = nbMax;
		}
		
		//toString
		public String toString() {
			String toReturn = "[";
			for(int i =0; i<tab.length-1; i++) {
				toReturn += tab[i] + ",";
			}
			toReturn += tab[tab.length-1];
			return "nom : " + nomTab + " // taille : " + taille + " \n " +toReturn + "]";
		}
		

		//Méthode max tab
		public int maxTab(int tailleMax) {
			int max = 0;
			int position = 0;
			for(int i=0; i<tailleMax; i++) {
				if(max<=this.tab[i]) {
					max = this.tab[i];
					position = i;
				}
			}
			return position;
		}

		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//############## Tris naif ##############
		
		//On va décomposer ce tris en "sous-méthodes"
		//Tout d'abord, on va échanger des valeurs de deux emplacements dans un meme tableau
		public void swaps(int i, int j) { 
			int aux = tab[i];
			tab[i]=tab[j];
			tab[j]=aux;
		}
		//On cherche ensuite le maximum de notre tableau
		public int posMax(int taille) {
			int p = 0;
			int m = tab[0];
			for(int i = 1; i<taille; i++) {
				if(tab[i]>m) {
				m = tab[i];
				p = i;
				}
			}
			return p;
		}
		//Et on regroupe :
		//On prend le maximum du tableau, on l'échange avec la dernière valeur du tableau, et on 
		//recommence avec un tableau un cran plus petit
		public void triN() {
			for( int i =0; i<this.tab.length; i++) {
				int p = posMax(this.tab.length-i);
				swaps(p, this.tab.length-i-1);
			}
		}
		
		//############## Tris a bulle ##############
		
		public static void triABulle(int[] tab) {
			boolean tri = false;
			// je suppose qu'il est trié .... je le parcours et dès que deux éléments consécutifs ne sont pas dans
	        // l'ordre, je les échange et je remets en cause mon hypothèse ..... trie = false .....
			while(!tri) {
				tri=true;
				for(int i=0; i<tab.length-1;i++) {
					if(tab[i+1] < tab[i]) {
						// dans ce cas, on échange les valeurs (i) et (i+1)
						int a = tab[i];
						tab[i] = tab[i+1];
						tab[i+1]= a;
						tri = false;
					}
				}
			}
		}
		
		//############## Tris fusion ##############
		
		//nb : la méthode divTab2(int[] tab) ne sert a rien, elle m'a juste servis à voir si je divisais 
		//convenablement mon tableau
		public static void divTab2(int[] tab) {
			int[] tab1 = new int[tab.length/2];
			int[] tab2 = new int[tab.length/2+tab.length%2];
			if(tab.length%2==0) {
				for(int i=0; i<tab1.length; i++) {
					tab1[i] = tab[i];
					tab2[i] = tab[i+tab.length/2];
				}
			}
			else {
				for(int i=0; i<tab.length/2; i++) {
					tab1[i] = tab[i];
					tab2[i] = tab[i+tab.length/2];
				}
				tab2[tab.length/2] = tab[tab.length-1];
			}
			//Pour tester cette méthode, retire simplement ces coms :
			//System.out.println(Arrays.toString(tab));
			//System.out.println(Arrays.toString(tab1));
			//System.out.println(Arrays.toString(tab2));
		}
		
		//#### On commence notre méthode seulement ici : #####
		
		private int[] trisFusion(int[] tab) { 
			//On divise d'abord le tab en deux parties
			int[] tab1 = new int[tab.length/2];
			int[] tab2 = new int[tab.length/2+tab.length%2];
			if(tab.length%2==0) {
				for(int i=0; i<tab1.length; i++) {
					tab1[i] = tab[i];
					tab2[i] = tab[i+tab.length/2];
				}
			}
			else {
				for(int i=0; i<tab.length/2; i++) {
					tab1[i] = tab[i];
					tab2[i] = tab[i+tab.length/2];
				}
				tab2[tab.length/2] = tab[tab.length-1];
			}
			//Et on recommence jusqu'a avoir des petits tab de 1case
			if(tab1.length>1) tab1= trisFusion(tab1);
			if(tab2.length>1) tab2= trisFusion(tab2);
			//On va maintenant fusionner tous les petits tableau dans le bon ordre, et ainsi trier le tab
			int c1 =0;
			int c2 =0;
			for(int i=0; i<tab.length;i++) {
				if(c1==tab1.length) {
					tab[i] = tab2[c2];
					c2++;
				}
				else if(c2==tab2.length) {
					tab[i] = tab1[c1];
					c1++;
				}
				else if(tab1[c1]<tab2[c2]) {
					tab[i] = tab1[c1];
					c1++;
				}
				else {
					tab[i] = tab2[c2];
					c2++;
				}
			}
			//On retourne le tab initial trié
			return tab;
		}
		
		//Pour appeler proprement notre méthode de trisFusion, on la met en "private", et on lui creer une 
		//méthode de petite interface, c'est cette méthode qu'on va appeler depuis notre main
		public void trisFusion() {
			this.tab = trisFusion(this.tab);
		}
		
		//############## Tris par tas ##############
		
		//cout étape 1 : nlog2(n)
		//cout étape 2 : 1
		//cout étape 3 : log2(n)
		//cout total : nlog2(n)
		//espace memoir utilisé : 1tab
		
		//Retourne indice du max des 3 elements d'un triangle (avec tab commence à 0)
		public int maxArbre(int i, int taille) {
			if(2*i+1>= taille) {
				return i;
			}
			else if(2*i+1 == taille-1) {
				if(tab[i]>=tab[i+1]) return i;
				else return 2*i+1;
			}
			else {
				if(tab[i]>=tab[2*i+1] && tab[i]>=tab[2*i+2]) return i;
				else if(tab[2*i+1]>=tab[2*i+2]) return 2*i+1;
				else return 2*i+2;
			}
		}
		
		//si pas le max en haut, on swaps le haute avec le max des deux fils
		public void reparation(int i, int taille) {
			int a = this.maxArbre(i, taille);
			if(i==a) {	
			}
			else {
				swaps(i, a);
				this.reparation(a, taille);
			}
		}
		
		public void initialisation() { 
			for(int k=taille/2; k>=0; k--) {
				reparation(k, taille);
			}
		}
		
		public void triParTas() {
			initialisation(); //étape 1
			for(int k=tab.length; k>=1; k--) { 
				swaps(0, k-1); //étape 2
				reparation(0,k-1); //étape 3
			}
		}
		
		//############## Tris rapide ##############
		
		private void triRapido(int debut, int fin) {
			int limite =0;
			int vlimite = tab[fin-1];
			for(int i=0; i<fin; i++) {
				if(tab[i]<=vlimite) {
					swaps(i, limite);
					limite++;
				}
				else {
					//do nothings
				}
			}
			if(limite - debut>1) {
				triRapido(debut,limite-1);
			}
			else {
				//do nothings
			}
			if(fin - limite>1) {
				triRapido(limite, fin);
			}
			else {
				//do nothings
			}
		}
		
		public void triRapido() { //méthode interface
			triRapido(0, this.taille);
		}
		
		
		//Main
		public static void main(String[] args) {
			//On creer des objets a trier :
			Tris tab1 = new Tris("tab 1",17,20);
			Tris tab2 = new Tris("tab 2",17,20);
			Tris tab3 = new Tris("tab 3", 17,20);
			Tris tab4 = new Tris("tab 4", 17,20);
			Tris tab5 = new Tris("tab 5", 17,20);
			//On appelle nos differentes fonctions :
			System.out.println("############# Tests fonctions bonus #############\n");
			System.out.println("max tab 1 : \n" + tab1.tab[tab1.maxTab(tab1.taille)] +" en : " + tab1.maxTab(tab1.taille) );
			System.out.println("\n############## Tris 'naif' ####################\n");
			System.out.println(tab1);
			tab1.triN();
			System.out.println("tab trié : \n" +tab1);
			System.out.println("\n############## Tris à bulle ####################\n");
			System.out.println(tab2);
			triABulle(tab2.tab);
			System.out.println("tab trié : \n" +tab2);
			System.out.println("\n############## Tris fusion ####################\n");
			System.out.println(tab3);
			tab3.trisFusion();
			System.out.println("tab trié : \n" +tab3);
			System.out.println("\n############## Tris par tas ####################\n");
			System.out.println(tab4);
			tab4.triParTas();
			System.out.println("tab trié : \n" +tab4);
			System.out.println("\n############## Tris rapide ####################\n");
			System.out.println(tab5);
			tab5.triRapido();
			System.out.println("tab trié :\n " +tab5);
		}
}