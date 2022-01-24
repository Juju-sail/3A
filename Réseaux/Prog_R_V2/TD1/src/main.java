import java.util.concurrent.ThreadLocalRandom;
//import java.util.stream.IntStream;


import mpi.*;

public class main {

	public static void main(String[] args) {

		// Pour voir mes reponses au questions du TD1, veuillez decommenter la question choisie

		MPI.Init(args);
		int myrank = MPI.COMM_WORLD.Rank(); 

		/* PARTIE 1 :
		 * Q1 : l.21
		 * Q2 : l.48
		 * Q3 : l.74
		 */


		/* QUESTION 1 : Deux moutons font du saute-moutons

		int x = 0;
		int y = 0;
		int[] xy = new int[2];

		for(int i = 0; i<20; i++) {
			if(myrank == 0) { // tache du mouton qui saute

				MPI.COMM_WORLD.Recv(xy, 0, 2, MPI.INT, 1, i);

				x = 2*xy[0] - x;
				y = 2*xy[1] - y;
			}else { // tache du mouton qui se deplace
				x = ThreadLocalRandom.current().nextInt();
				y = ThreadLocalRandom.current().nextInt();

				xy[0] = x;
				xy[1] = y;

				MPI.COMM_WORLD.Send(xy, 0, 2, MPI.INT, 0, i);
			}
			System.out.println("Mouton " + myrank + " : ("+ x+ ","+ y+")");
		}
		 */


		/* QUESTION 2 : Trois moutons font du saute-moutons 
		// Plus de moutons -> change le -np de la config
		int x = ThreadLocalRandom.current().nextInt();
		int y = ThreadLocalRandom.current().nextInt();
		int[] xy = new int[2];
		int[] receptiontab = new int[2];

		int prev = (myrank+2)%3;
		int next = (myrank+1)%3;

		for (int i = 0; i<20; i++) {
			Request req = MPI.COMM_WORLD.Isend(xy, 0, 2, MPI.INT, prev, i);
			MPI.COMM_WORLD.Recv(receptiontab, 0, 2, MPI.INT, next, i);
			//mise à jour de mes coord actuelles :
			x = 2*receptiontab[0] - x;
			y = 2*receptiontab[1] - y;
			req.Wait();
			// Coord à envoyer :
			xy[0] = x;
			xy[1] = y;

			System.out.println("Mouton " + myrank + " : ("+ x+ ","+ y+")");
		}

		 */

		/* QUESTION 3 : saute-moutons à n moutons
		// le n est choisi directement dans le run config via le VM argument ! 
		// si on dit -np 3 alors trois moutons vont sauter, si on dit -np 15, ils seront 15 à jouer

		int x = ThreadLocalRandom.current().nextInt();
		int y = ThreadLocalRandom.current().nextInt();
		int[] xy = new int[2];
		int[] receptiontab = new int[2];

		int size = MPI.COMM_WORLD.Size(); 

		int prev = (myrank+size-1)%size;
		int next = (myrank+1)%size;

		for (int i = 0; i<20; i++) {
			Request req = MPI.COMM_WORLD.Isend(xy, 0, 2, MPI.INT, prev, i);
			MPI.COMM_WORLD.Recv(receptiontab, 0, 2, MPI.INT, next, i);
			//mise à jour de mes coord actuelles :
			x = 2*receptiontab[0] - x;
			y = 2*receptiontab[1] - y;
			req.Wait();
			// Coord à envoyer :
			xy[0] = x;
			xy[1] = y;

			System.out.println("Mouton " + myrank + " : ("+ x+ ","+ y+")");
		}
		 */

		/* PARTIE 2 :
		 * Q1 : l.109
		 * Q2 : l.116 et l.150
		 */

		/* QUESTION 1 : domaine de travail
		int x = ThreadLocalRandom.current().nextInt(-20, 20);
		int y = ThreadLocalRandom.current().nextInt(-20,20);
		int[] xy = new int[2];
		System.out.println("("+x+","+y+")");
		 */ 

		/* QUESTION 2 : portée limitée
		int x = ThreadLocalRandom.current().nextInt(-20, 20);
		int y = ThreadLocalRandom.current().nextInt(-20,20);
		int[] xy = new int[2];
		int[] receptiontab = new int[2];

		int size = MPI.COMM_WORLD.Size(); 

		int prev = (myrank+size-1)%size;
		int next = (myrank+1)%size;


		int i = 0;

		while(-200<x && x<200 &&  -200 <y && y<200) {
			Request req = MPI.COMM_WORLD.Isend(xy, 0, 2, MPI.INT, prev, i);
			MPI.COMM_WORLD.Recv(receptiontab, 0, 2, MPI.INT, next, i);
			//mise à jour de mes coord actuelles :
			x = 2*receptiontab[0] - x;
			y = 2*receptiontab[1] - y;
			if(-200>x || x>200 || -200 >y || y>200)break;
			req.Wait();
			// Coord à envoyer :
			xy[0] = x;
			xy[1] = y;

			i++;
			System.out.println("Mouton " + myrank + " : ("+ x+ ","+ y+")");

		}
		System.out.println("fin de moutons" + myrank);
		 */
		
		/* La question n'était pas vraiment celle-là, 
		// il fallait arreter quand un mouton voualait sauter au dessus d'un autre, mais qu'il était trop loin ! 
		// on va aussi essayer de stoper tous les moutons dès qu'un ne peut plus sauter
		
		// C'est la PARTIE 3
		
		int x = ThreadLocalRandom.current().nextInt(-20, 20);
		int y = ThreadLocalRandom.current().nextInt(-20,20);
		int[] xy = new int[] {x,y};
		int[] receptiontab = new int[2];

		int size = MPI.COMM_WORLD.Size(); 
		
		int prev = (myrank+size-1)%size;
		int next = (myrank+1)%size;
		
		boolean[] alive = new boolean[1];
		boolean[] state = new boolean[size];
		
		alive[0] = true;

		int i = 0;

		while(alive[0]) {
			Request req = MPI.COMM_WORLD.Isend(xy, 0, 2, MPI.INT, prev, i);
			MPI.COMM_WORLD.Recv(receptiontab, 0, 2, MPI.INT, next, i);
			req.Wait();
			
			if(Math.pow(2*receptiontab[0]-2*xy[0], 2) + Math.pow(2*receptiontab[1]-2*xy[1], 2)<= 250000) {
				xy[0] = 2*receptiontab[0] - xy[0];
				xy[1] = 2*receptiontab[1] - xy[1];
				System.out.println("Mouton " + myrank + " saut n°" + i + " : ("+ xy[0]+ ","+ xy[1]+")");
			}
			else {
				alive[0] = false;
				System.out.println("Mouton " + myrank + " saut n°" + i + " impossible !");
			}

			if(myrank == 0) {
				for(int j = 1; j<size; j++) {
					MPI.COMM_WORLD.Recv(state, j, 1, MPI.BOOLEAN, j, i);
				}
				state[0] = alive[0];
				for(boolean b : state) {
					if(!b) {
						alive[0] = false;
					}
				}
				for(int j = 1; j<size;j++) {
					MPI.COMM_WORLD.Send(alive, 0, 1, MPI.BOOLEAN, j, i);
				}
			}else {
				MPI.COMM_WORLD.Send(alive, 0, 1, MPI.BOOLEAN, 0, i);
				MPI.COMM_WORLD.Recv(alive, 0, 1, MPI.BOOLEAN, 0, i);
			}
			i++;
		}
		
		*/

		MPI.Finalize();
	}
}
