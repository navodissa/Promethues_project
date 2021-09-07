package TESTapp_amm.password_manager;
import java.io.IOException;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.DumperOptions;
import TEST.fnd.buildtasks.*;
import TEST.fnd.buildtasks.Encryption.EncryptionException;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 * Hello world!
 *
 */
public class MainApplication 
{
    public static void main( String[] args )
    {
        Boolean updateFile = false;
        DumperOptions options = new DumperOptions();
     	options.setDefaultFlowStyle(DumperOptions.FlowStyle.BLOCK);
        options.setPrettyFlow(true);
        Yaml yaml = new Yaml(options);
        InputStream inputStream = null;
		try {
			inputStream = new FileInputStream(args[0]);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
  		Map<String, Object> obj = yaml.load(inputStream); 

        try{
           if(args[1] !=  null){
              obj.put("TEST_user", args[1]);
              updateFile = true;
           }
           if(args[2] !=  null){
               obj.put("TEST_pass", Encryption.encrypt(args[2]));
               updateFile = true;
            }
           if(args[3] != null){
              obj.put("db_user", args[3]);
              updateFile = true;
           }
           if(args[4] != null){
               obj.put("db_pass", Encryption.encrypt(args[4]));
               updateFile = true;
            }
           if(args[5] !=  null){
               obj.put("mws_monit_user", args[5]);
               updateFile = true;
            }
            if(args[6] != null){
               obj.put("mws_monit_pass", Encryption.encrypt(args[6]));
               updateFile = true;
            }
            if(args[7] !=  null){
                obj.put("pso_monit_user", args[7]);
                updateFile = true;
             }
            if(args[8] !=  null){
               obj.put("pso_monit_pass", Encryption.encrypt(args[8]));
               updateFile = true;
            }
            if(args[9] != null){
               obj.put("fsm_monit_user", args[9]);
               updateFile = true;
            }
             if(args[10] != null){
                obj.put("fsm_monit_pass", Encryption.encrypt(args[10]));
                updateFile = true;
             }            
        }catch (EncryptionException ex) {
           ex.printStackTrace();
        }
        if(updateFile){
           FileWriter writer = null;
		try {
			writer = new FileWriter(args[0]);
	        yaml.dump(obj,writer);
	        inputStream.close();
	        writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

        }
    }
}
