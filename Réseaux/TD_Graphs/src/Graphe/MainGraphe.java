package Graphe;

import java.io.IOException;

public class MainGraphe {

	public static void main(String[] args) throws IOException {
		Graphe G = new Graphe(5);
		G.addArete(1,3,2);
		G.addArete(0,3,3.3);
		G.addArete(1,4);
		G.addArete(2,3,5.5);
		G.addArete(2,4,0.1);
		System.out.println("Arbre G : " + G);
		System.out.println("G en BFS : " + G.BFS(3));
		System.out.println("G en dijkstra :" + G.Dijkstra(3));
		try{
			//G.outputDOT(G.BFS(3));
			G.outputDOT(G.Dijkstra(3));
			//G.BFS(3).outputDOT();
		}
		catch(IOException e) {
			e.getMessage();
		};
		
		
		
		
	}

}
