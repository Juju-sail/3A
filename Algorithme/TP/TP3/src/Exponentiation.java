public class Exponentiation {
	static int c=0;
	//Qt° 1 :
	public static int PuissMult(int n, int p) {
		int m = 1;
		for(int i =0; i<p;i++) {
			m = m*n;
		}
		return m;
	} //Complexité : p
	//Qt° 3 : 
	public static int PuissRec(int n, int p) {
		int m=1;
		if(p==0)m=1;
		else if(p%2==0) {
			m= PuissRec(n, p/2);
			m=m*m;
			Exponentiation.c +=1;
		}
		else {
			m= PuissRec(n, (p-1)/2);
			m=m*m*n;
			Exponentiation.c +=1;
		}
		return m;
	} //Complexité : c (voir dans le main)
	//Main: 
	public static void main(String[] args) {
		System.out.println(PuissMult(2, 11));
		System.out.println(c);
		System.out.println(PuissRec(2, 11));
		System.out.println(c); //Donne la complexité de la méthode appellée juste avant
	}
}