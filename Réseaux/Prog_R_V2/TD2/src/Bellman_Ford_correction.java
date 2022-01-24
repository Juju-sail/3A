import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import mpi.*;

public class Bellman_Ford_correction {
	
	public static int readFile(String filePath, int rank, Map<Integer,Integer> oWeights) throws IOException {
		
		BufferedReader file = new BufferedReader(new FileReader(filePath));

		int n = Integer.parseInt(file.readLine());

		for(int i=0; i<rank; i++) {
			file.readLine();
		}

		String[] weights = file.readLine().split(" ");
		//System.out.println(rank +":" + weights.length);
		file.close();

		for(String wString : weights) {
			String[] wInfo = wString.split(":");
			if(wInfo.length == 2) {
				oWeights.put(Integer.parseInt(wInfo[0]), Integer.parseInt(wInfo[1]));
				//System.out.println(rank +" "+ wInfo[0] + " "+ wInfo[1]);
			}
		}
		
		//System.out.println(rank +":" + oWeights.size());

		return n;
	}
	
	public static List<Integer> exploration(int rank, int size, Set<Integer> voisins) {
		
		boolean[][] rec = new boolean[size-1][1];
		Request[] rT = new Request[size-1];
		
		for(int i=0; i<size-1; i++) {
			if(i<rank) {
				rT[i] = MPI.COMM_WORLD.Irecv(rec[i], 0, 1, MPI.BOOLEAN, i, 0);
			} else if(i>=rank) {
				rT[i] = MPI.COMM_WORLD.Irecv(rec[i], 0, 1, MPI.BOOLEAN, i+1, 0);
			}
		}
		
		for(int v: voisins) {
			MPI.COMM_WORLD.Ssend(new boolean[] {true}, 0, 1, MPI.BOOLEAN, v, 0);
		}
		
		MPI.COMM_WORLD.Barrier();
		
		ArrayList<Integer> vList = new ArrayList<>();
		
		for(int i=0; i<size; i++) {
			if(i<rank) {
				if(rT[i].Test()!=null) {
					vList.add(i);
				} else {
					//rT[i].Cancel();
				}
			} else if(i>rank) {
				if(rT[i-1].Test()!=null) {
					vList.add(i);
				} else {
					//rT[i-1].Cancel();
				}
			}
		}
		
		return vList;
	}
	
	public static int[] initDistance(int rank, int size, Map<Integer,Integer> poids) {
		int[] d = new int[size];

		for(int i=0; i<size; i++) {
			if(poids.containsKey(i)) {
				d[i]=poids.get(i);
			} else if(i!=rank) {
				d[i] = Integer.MAX_VALUE;
			} else {
				d[i] = 0;
			}
		}
		
		return d;
	}

	public static void main(String[] args) {
		
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
		
		poids.remove(rank);
		final List<Integer> sendList = exploration(rank, size, poids.keySet());
		
		int[] d = initDistance(rank, size, poids);
		
		boolean[] changed = new boolean[] {true};
		boolean[] state = new boolean[size];
		
		int i = 0;
		
		while(changed[0]) {
			
			/*
			if(i == 2) {
				if (rank == 0) {
					poids.put(2, 4);
				} else if(rank == 2) {
					poids.put(0, 4);
				}
			}*/
			
			int[] di = d; //initDistance(rank, size, poids);
			
			changed[0] = false;
			Request[] rT = new Request[poids.size()];
			
			int j = 0;
			for(int v : sendList) {
				rT[j] = MPI.COMM_WORLD.Isend(d, 0, size, MPI.INT, v, i);
				j++;
			}
			
			Map<Integer,int[]> dM = new HashMap<>();
			for(int v : poids.keySet()) {
				int[] dv = new int[size];
				MPI.COMM_WORLD.Recv(dv, 0, size, MPI.INT, v, i);
				dM.put(v, dv);
			}
			
			for(int v : poids.keySet()) {
				int[] dv = dM.get(v);
				
				for(int w=0; w<size; w++) {
					if(dv[w] != Integer.MAX_VALUE && di[w] > dv[w] + d[v]) {
						di[w] = dv[w]  + d[v];
					}
				}
			}
			
			/*
			int[] dv = new int[size];
			for(int v : poids.keySet()) {
				MPI.COMM_WORLD.Recv(dv, 0, size, MPI.INT, v, i);
				
				for(int w=0; w<size; w++) {
					if(dv[w] != Integer.MAX_VALUE && di[w] > dv[w] + poids.get(v)) {
						di[w] = dv[w] + poids.get(v);
					}
				}
			}*/
			
			Request.Waitall(rT);
			
			for(int v=0; v<size; v++) {
				if(d[v] != di[v]) {
					d[v] = di[v];
					changed[0] = true;
				}
			}
			
			MPI.COMM_WORLD.Allgather(changed, 0, 1, MPI.BOOLEAN, state, 0, 1, MPI.BOOLEAN);
			
			for(boolean b : state) {
				if(b) {
					changed[0] = true;
				}
			}
			
			i++;
			
		}
		
		System.out.println("Noeud "+rank+" : "+Arrays.toString(d));
		

		MPI.Finalize();
	}
}