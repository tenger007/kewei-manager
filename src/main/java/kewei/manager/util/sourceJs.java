package kewei.manager.util;

import java.util.Collection;
import java.util.List;

import kewei.manager.bean.Article_Downloader;
import kewei.manager.bean.ICPostJsonBeanVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.JavaIdentifierTransformer;

public class sourceJs {
    public static void main(String[] args) {
        String tString = "[{'Id':463783,'Title':'Hanson','Author':null,'PublishedDate':'1504942980000','PublishedDateStr':'2017-09-09','Abstract':'','Keywords':'tr','Content':'要走','Url':'https://www.leiphone.com/news/201709/5iR9LjQqxYMtr4jr.html','SiteName':'雷锋网','Source':'re','ChannelId':1180,'Attachments':[],'Extras':[]}]";
        JSONArray fromObject = JSONArray.fromObject(tString);
       // JSONObject jsonObj1 = JSONObject.fromObject(tString);
        JsonConfig config = new JsonConfig();
        config.setJavaIdentifierTransformer(new JavaIdentifierTransformer() {

            @Override
            public String transformToJavaIdentifier(String str) {
                char[] chars = str.toCharArray();
                chars[0] = Character.toLowerCase(chars[0]);
                return new String(chars);
            }

        });
        config.setRootClass(Article_Downloader.class);
        List list = JSONArray.toList(fromObject, config);
        List<Article_Downloader> collection = (List<Article_Downloader>) JSONArray.toCollection(fromObject, config);
        //ICPostJsonBeanVO p2 = (ICPostJsonBeanVO) JSONObject.toBean(jsonObj1, config);
        System.out.println(list.get(0).toString());
       // System.out.println("json转化为对象：方法名：" + p2.getFuncName() + ";数量:" + p2.getParamNum() + "值：" + p2.getParamValue());
    }
}