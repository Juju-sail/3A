
public class Hachage<T> {
	//Attributs
	Object[] alveole;
	int size;
	
	//Constructeur
	public public public Hachage(int size) {
		if (size<1);
		this.size=size;
		alveole=new Object[size];
		}
		
	
	public static int HashFonction(String clef) {
		int hashClef=0;
		for (int i=0;i<clef.length();i++) {
			hashClef+=(int)clef.charAt(i);
		}
		return hashClef;
	}
	
	//toString
	public String toString() {
		String toReturn ="";
		for(int i=0; i<size;i++) {
			if(alveole[i]!=null)
				toReturn+=alveole[i].toString() +")";
			else toReturn+=",";
		}
		return toReturn;
	}
	
	public static void main(String[] args) {
		Hachage<Integer> table = new Hachage<Integer>(10);
		System.out.println(table);
	}
	
}
