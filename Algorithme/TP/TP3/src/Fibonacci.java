public class Fibonacci {
	//Fibonacci recursive classique
	public static int Fibo(int n) {
		if(n==1||n==2) 
			return 1;
		else if(n==0)
			return 0;
			else
				return Fibo(n-1)+Fibo(n-2);
	}
	//Fibonacci recursive avec tab
	public static int FiboTab(int n) {
		int[] t = new int[n+1];
		t[0]=0; t[1]=1; t[2]=1;
		return FiboAux(n, t);
	}
	public static int FiboAux(int n, int[] t) {
		if(n==0) t[n]=0;
		else if(t[n]==0)
			t[n] = FiboAux(n-1, t) + FiboAux(n-2, t);
		return t[n];
		
	}
	//Fibonacci iteratif classique
	public static int FiboIT(int n) {
		int nb=0; int nb1=0; int nb2=1;
		for(int i=0; i<n-1; i++) {
			nb = nb2 + nb1;
			nb1 = nb2;
			nb2 = nb;
		}
		return nb;
	}
	//Main
	public static void main(String[] args) {
		System.out.println(Fibo(20));
		System.out.println(FiboTab(20));
		System.out.println(FiboIT(20));
		
	}
}