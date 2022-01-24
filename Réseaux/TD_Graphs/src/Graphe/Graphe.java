package Graphe;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.PriorityQueue;
import java.util.Vector;

public class Graphe{

	Vector<Sommet> sommets=new Vector<Sommet>();
	int size;
	
	public Graphe(int size){
		this.size=size;
		for(int id=0;id<size;id++) {
			sommets.add(new Sommet(id));
		}
	}
	
	public Graphe() {
	}

	public void addArete(int i, int j, double poids) {
		sommets.get(i).addVoisin(sommets.get(j), poids);
		sommets.get(j).addVoisin(sommets.get(i), poids);
	}
	
	public void addArete(int i, int j) {
		sommets.get(i).addVoisin(sommets.get(j));
		sommets.get(j).addVoisin(sommets.get(i));
	}
		
	public boolean isVoisin(int i, int j) {
		return sommets.get(i).isVoisin(sommets.get(j));
	}
	
	public double poidsVoisin(int i, int j) {
		return sommets.get(i).poidsVoisin(sommets.get(j));
	}

	@Override
	public String toString() {
		String str="";
		for (int i=0;i<size;i++)str+=sommets.get(i)+" ";
		return str;
	}
	
	/**
	 * @brief Ecrit dans un fichier.txt les arretes d'un graphe
	 * Le texte peut etre interprété par un visionneur en ligne 
	 * @throws IOException
	 */
	public void outputDOT() throws IOException{
		File myFile = new File("D:/juliette/Documents/_PolytechNancy/Cours/2i/3A/Réseaux/TD_Graphs/test.txt");
		FileWriter fw = new FileWriter(myFile.getAbsoluteFile());
		fw.write("graph G{\n");
		for (int i = 0;i<sommets.size();i++) {
			fw.write(sommets.get(i).outputVoisin());
		}
		fw.write("}");
		fw.close();
	}
	
	public void outputDOT(Graphe G) throws IOException{
		File myFile = new File("D:/juliette/Documents/_PolytechNancy/Cours/2i/3A/Réseaux/TD_Graphs/test.txt");
		FileWriter fw = new FileWriter(myFile.getAbsoluteFile());
		fw.write("graph G{\n");
		for (int i = 0;i<sommets.size();i++) {
			fw.write(sommets.get(i).outputVoisin(G));
		}
		fw.write("}");
		fw.close();
	}
	
	/**
	 * Calcul un arbre couvrant BFS en partant d'une racine 
	 * @param r la racine en question
	 * @return un graph BFS
	 */
	public Graphe BFS(int r) {
		for(int i=0; i<this.size; i++) {
			this.sommets.get(i).flag = false;
		}
		Graphe bfs = new Graphe(this.size);
		LinkedList<Integer> Q = new LinkedList<Integer>();
		Q.add(r);
		this.sommets.get(r).flag = true;
		while(Q.size() != 0) {
			Sommet currentS = this.sommets.get(Q.getFirst());
			for(int i = 0; i<currentS.voisins.size(); i++) {
				Sommet currentV = currentS.voisins.get(i);
				if(!currentV.flag) {
					bfs.addArete(currentS.id, currentV.id);
					currentV.flag = true;
					Q.add(currentV.id);
				}
			}
			Q.remove();
		}
		for(int i=0; i<this.size;i++) {
			this.sommets.get(i).flag = false;
			return bfs;
		}
		return this;
	}
	
	
	public Graphe Dijkstra(int r) {
		
		Graphe arbre = new Graphe(this.size);
		PriorityQueue<Sommet> Q = new PriorityQueue<Sommet>();
		Q.add(sommets.get(r));
		this.sommets.get(r).poidsCourant = 0.0;
		
		while(Q.size() != 0) {
			Sommet currentS = Q.poll();
			if(currentS.voisinPrecedent != null) arbre.addArete(currentS.id, currentS.voisinPrecedent.id);
			for(int i = 0; i<currentS.voisins.size(); i++) {
				Sommet currentV = currentS.voisins.get(i);
				if(currentV.poidsCourant == null || (currentS.poidsCourant + poidsVoisin(currentV.id, currentS.id))<currentV.poidsCourant) {
					currentV.poidsCourant = currentS.poidsCourant + poidsVoisin(currentV.id, currentS.id);
					currentV.voisinPrecedent = currentS;
					Q.add(currentV);
				}
			}
		}
		return arbre;
	}
	
}
