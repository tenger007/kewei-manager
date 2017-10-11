package kewei.manager.bean;

public class ICPostJsonBeanVO {
 private String funcName;
 private String paramNum;
 private String paramValue;
public String getFuncName() {
	return funcName;
}
public void setFuncName(String funcName) {
	this.funcName = funcName;
}
public String getParamNum() {
	return paramNum;
}
public void setParamNum(String paramNum) {
	this.paramNum = paramNum;
}
public String getParamValue() {
	return paramValue;
}
public void setParamValue(String paramValue) {
	this.paramValue = paramValue;
}
@Override
public String toString() {
	return "ICPostJsonBeanVO [funcName=" + funcName + ", paramNum=" + paramNum + ", paramValue=" + paramValue + "]";
}
 
 
}
