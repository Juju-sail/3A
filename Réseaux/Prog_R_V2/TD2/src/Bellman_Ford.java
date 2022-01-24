import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


import mpi.*;

public class Bellman_Ford {

	public static int readFile(String filePath, int rank, Map<Integer,Integer> oWeights) throws IOException {

		BufferedReader file = new BufferedReader(new FileReader(filePath));

		int n = Integer.parseInt(file.readLine());

		for(int i=0; i<rank; i++) {
			file.readLine();
		}

		String[] weights = file.readLine().split(" ");
		file.close();

		for(String wString : weights) {
			String[] wInfo = wString.split(":");
			if(wInfo.length == 2) {
				oWeights.put(Integer.parseInt(wInfo[0]), Integer.parseInt(wInfo[1]));
			}
		}

		return n;
	}
	
	
	
	
	

	public static void main(String[] args) throws IOException {

		MPI.Init(args);

		int rank = MPI.COMM_WORLD.Rank();
		int size = MPI.COMM_WORLD.Size();
		
		

		Map<Integer,Integer> poids = new HashMap<>();

		try {
			int n = readFile("D:\\juliette\\Documents\\_PolytechNancy\\Cours\\2i\\3A\\Réseaux\\Prog_R_V2\\TD2\\example_cours", rank, poids);

			if (size != n) {
				if(rank == 0) {
					System.out.println("Le graphe n'a pas le même nombre de noeuds que le programme MPI : " + n);
				}
				return;
			}
		} catch (IOException e) {
			if(rank==0) {
				e.printStackTrace();
			}
			return;
		} catch (NumberFormatException e) {
			if(rank==0) {
				System.out.println("Erreur lors de la lecture du fichier:");
				e.printStackTrace();
			}
			return;
		}

		//TODO
		// V : ensemble des neouds du graph
		// E : ensemble des arretes du graph
		// d : tableau contenant les distance entre 1 neouds et tous les autres neouds du graph
		int[] d = new int[size];

		// initialisation :
		for(int v = 0; v<size; v++) { // parcours de V
			if(v == rank){ // rank <=> u
				d[v] = 0 ;
			}
			else if(poids.containsKey(v)) { // si un poids dans v (à partir de u) existe, alors 
				d[v] = poids.get(v); // d[v] = poids(u; v)
			}
			else {
				d[v] = Integer.MAX_VALUE; // d[v] = infini
			}
		}

		int[] dv = new int[size]; // tab de reception
		
		Request[] req = new Request[size]; //creation tab de request pour pas perdre l'info

		for(int i = 0; i<size; i++) {
			for(int v : poids.keySet()) { // pour chaque arrete de E
				req[i] = MPI.COMM_WORLD.Isend(d, 0, size, MPI.INT, v, i);// Envoie d au nœud v // NB :toujours u qui appelle l'envoi/reception ;  Send(message, premier element envoyé, longueur, type, qui recois, id du message)
			}
			for(int v : poids.keySet()) {
				MPI.COMM_WORLD.Recv(dv, 0, size, MPI.INT, v, i); // (tab pour stocker reception, premier elem recu, taille >= taille envoyée, type, envoyeur, id)
				for(int w = 0; w<size; w++) {
					if(dv[w] != Integer.MAX_VALUE) { // verrifie qu'on a pas d'arretes inconnues (car calcul sur poids infini : pb)
						if(dv[w] + d[v] < d[w]){
							d[w] = dv[w] + d[v];
						}
					}
				}
			}
			req[i].Wait();
		}
		
		System.out.println("u : " + rank + " // d : " + Arrays.toString(d));
		MPI.Finalize();
	}
}