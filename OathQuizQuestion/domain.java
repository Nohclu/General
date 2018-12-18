import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class oathQ{ 

    public ArrayList<String> getDomains(ArrayList<String> arr){
        Map<String, Integer> d = new HashMap<String, Integer>();
        ArrayList<String> output = new ArrayList<String>();
        String s = String.join("",arr);
        String pattern = "www.\\w*.\\w*";
        
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(s);
        
        while(m.find()){
            if(d.containsKey(m.group())){
                d.put(m.group(), d.get(m.group()) + 1);
            } else {
                d.put(m.group(), 1);
            }
        }
        for(Map.Entry<String, Integer> entry : d.entrySet()){
            String conc = entry.getKey() + " " +Integer.toString(entry.getValue());
            output.add(conc);
        }
        return output;
    }

    public static void main(String[] args) {
        ArrayList<String> domains = new ArrayList<String>();
        domains.add("https://www.yahoo.com/somerandomstring");
        domains.add("http://www.yahoo.com/some/random/string");
        domains.add("http://www.google.com");
        oathQ myClass = new oathQ();
        ArrayList<String> al = myClass.getDomains(domains);
        for(String s: al){
            System.out.println(s);
        }
    }
}