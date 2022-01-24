import java.util.Dictionary;
import java.util.Hashtable;
import mpi.MPI;
import mpi.Request;

public class Algo1 {
	//encodage de l’entier i en un tableau de booleen minimal
	public static boolean[] fromInt(int i) {
	return fromInt(i, (int) Math.floor(Math.log(i)/Math.log(2)) +1);
	}
	//encodage d’un entier b en un tableau de k booleen
	public static boolean[] fromInt(int b, int k) {
	boolean [] flags = new boolean[k];
	for (int j = 0; j < k; j++) {
		flags[j] = (b & (1 << j)) != 0;
	
	}
	return flags;
	}
	//decodage d’un tableau de booleen bt en un entier
	public static int toInt(boolean[] bt) {
	int i = 0;
	for (int j = 0; j < bt.length; j++) {
		if (bt[j]) i |= (1 << j);
	}
	return i;

	}
	
	
	public static boolean[] c(int size, int u) {
		boolean[] c = fromInt(u, size);
		return c;
	}
	
	public static boolean ck(boolean[] c, int size) {
		boolean ck = c[size]; // retourne le bit de poids faible d'une couleur
		return ck;
	}
	
	public static int kdifferents(boolean[] cu, boolean[] cv, int size) {
		int bit = -1; // initialise arbitrairement l'indice du bit different à -1 (valeur impossible)
		for(int i=0; i<size; i--) { // on parcours 
			if(cu[i] != cv[i]) { // met de coté l'indice du premier bit different (poids faible)
				bit = i;
			}
			else {
				bit = -2; // sauf si les deux couleurs sont identiques
			}
		}
		return bit;
		
	}
	

	public static void changementu(boolean[] cu, boolean[] cv, int size) {
		int k = kdifferents(cu, cv, size);
		if(k != -2) {
			if(cu[k] == true) {
				cu[k] = false;
			}
			else {
				cu[k] = true;
			}
		}
	}
	
	public static void main(String[] args) {
		MPI.Init(args);
		int n = MPI.COMM_WORLD.Size();
		int u = MPI.COMM_WORLD.Rank();
		
		int gauche = (u+n-1)%n;
		int droite = (u+1)%n;
		
		Request[] req = new Request[n];
		boolean[] tabrecep = new boolean[n];

		boolean[] cu = c(n, u);
		boolean[] cv = c(n, droite);
		boolean[] cw = c(n,gauche);
		
		for(int i = 0; i< n ; i++) {
			req[i] = MPI.COMM_WORLD.Isend(cu, 0, n, MPI.BOOLEAN, droite, i);// Isend(message, premier element envoyé, longueur, type, qui recois, id du message)
		}
		for(int i =0; i<n; i++) {
			req[i].Wait();
			MPI.COMM_WORLD.Recv(tabrecep, 0, n, MPI.BOOLEAN, u, i); // Recv(tab pour stocker reception, premier elem recu, taille >= taille envoyée, type, envoyeur, id)
			changementu(tabrecep, cv, n);
		}
		
		int nbcolors = 4;
		Request[] req2 = new Request[n];
		Dictionary<Integer, boolean[]> couleurs = new Hashtable<Integer, boolean[]>();
		
		
		for(int i = 0 ; i < nbcolors; i++) {
			req2[i] = MPI.COMM_WORLD.Isend(cu, 0, n, MPI.BOOLEAN, droite + gauche, i*2+1);
		}
		for(int i = 0 ; i < nbcolors; i++) {
			req2[i].Wait();
			MPI.COMM_WORLD.Recv(cv, 0, n+1, MPI.BOOLEAN, gauche, i*2+1); 
			MPI.COMM_WORLD.Recv(cw, 0, n, MPI.BOOLEAN, droite, 2*i+1);
		}
		couleurs.put(1, cu);
		couleurs.put(2, cv);
		couleurs.put(3, cw);
		for(int i = 0; i < nbcolors; i++) {
			if(cu == couleurs.get(i%nbcolors)) {
				int numCol = 0;
				if(i == 1) {
					if(cv == couleurs.get(2)) numCol = 3;
					else numCol = 2;
				}
				else if( i == 2) {
					if(cv == couleurs.get(1)) numCol = 3;
					else numCol = 1;
				}
				else {
					if(cv == couleurs.get(3)) numCol = 1;
					else numCol = 2;
				}
				cu = couleurs.get(numCol);
			}
		}
		
		MPI.Finalize();
	}
}
