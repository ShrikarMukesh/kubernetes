public class Hai {
    public static void main(String[] as) throws InterruptedException {
        System.out.println("Hello Docker cmds and variables");
        System.out.println("I Am Hai.java class");
        for(String str: as ){
            System.out.println(str);
        }
        for (int i =1;i <=10; i++){
            Thread.sleep(5000);
        }
    }

}