package kewei.manager.util;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;

import kewei.manager.bean.Article_Downloader;
import kewei.manager.bean.Downloader_record;
import kewei.manager.service.JsdManagerServiceInf;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.JavaIdentifierTransformer;

public class MyQuartzJobBean extends QuartzJobBean {
	private JsdManagerServiceInf jsdServiceInf;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		List<String> jsdnames = jsdServiceInf.get_all_jsdDownloader();
		for(String jsdname:jsdnames){
			Downloader_record jsDownloader_record = jsdServiceInf.get_jsdDownloader_channel(jsdname);
			String updatetime = jsDownloader_record.getUpdatetime();
			String channelId = jsDownloader_record.getChannel_id();
			String time2="";
			try {
				time2 = URLEncoder.encode(updatetime,"utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String jsonSize = DownloaderUtil.loadJsonSize("http://zhxinfo.yuncis.com/articles/count?channelids="+channelId+"&datefrom="+time2);
			int i1 = Integer.parseInt(jsonSize);
			if(i1>0){
				List<Article_Downloader> article_Downloaders = new ArrayList<Article_Downloader>();
				for(int j = 1;j<=i1/500+1;j++){
					String loadJson = DownloaderUtil.loadJson("http://zhxinfo.yuncis.com/articles/list?channelids="+channelId+"&datefrom="+time2+"&page="+j+"&size="+500);
					JSONArray fromObject = JSONArray.fromObject(loadJson);
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
				       article_Downloaders.addAll((List<Article_Downloader>) JSONArray.toCollection(fromObject, config));
						}
	        for(int i = 0;i<article_Downloaders.size();i++){
	        	article_Downloaders.get(i).setJsdname(jsdname);
	        }
	        jsdServiceInf.insert_article_Downloaders(article_Downloaders);
	        Downloader_record downloader_record = new Downloader_record();
	        downloader_record.setChannel_id(channelId);
	        downloader_record.setJsdname(jsdname);
	        downloader_record.setSize(Integer.parseInt(jsonSize)+jsDownloader_record.getSize());
	        downloader_record.setThis_size(Integer.parseInt(jsonSize));
	        jsdServiceInf.insert_downloader_record(downloader_record);
			}
		}
		
	}
	
	public void setJsdServiceInf(JsdManagerServiceInf jsdServiceInf) {
		this.jsdServiceInf = jsdServiceInf;
	}
	
}
