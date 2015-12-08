package com.taoren.admin.util;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Map;
import java.util.List;


public class MiscUtil
{
	public static final String STR_SEPARATER		= "\234";
	public static final String COMMA_SEPARATER	= ",";
	
	
	/**
	 * String & collection
	 * 
	 * @param o
	 * @return
	 */
	public static boolean isNotEmpty(Object o)
	{
		boolean notEmpty = false;
		
		if (o instanceof String)
		{
			String s = (String)o;
			if (s != null && !"".equals(s.trim()))
				notEmpty = true;
		}
		else if (o instanceof Collection)
		{
			Collection c = (Collection)o;
			if (c != null && c.size() !=0)
				notEmpty = true;
		}
		
		return (notEmpty);
	}
	
	/**
	 * fields[]: first letter is upercase
	 * 
	 * @param l
	 * @param clazz
	 * @param desc
	 * @return
	 */
	public static String[][] getMatrix(List l, Class clazz, String[] fields)
	{
		String[][] matrix = null;
		
		if (l != null && fields != null)
		{
			int row_num = l.size();
			int col_num = fields.length;
			
			matrix = new String[row_num][col_num];
			Method mget = null;
			
			try
			{
				//	row
				int row = 0;
				for (Object o : l)
				//for (int row = 0; row < row_num; row++)
				{
					for(int col = 0; col < col_num; col++)
					{
						mget = clazz.getMethod("get"+fields[col], new Class[0]);
						matrix[row][col] = (String)mget.invoke(o, new Object[0]);
					}				
					row++;
				}	
			}
			catch (IllegalAccessException e)
			{
				e.printStackTrace();
			}
			catch (NoSuchMethodException e)
			{
				e.printStackTrace();
			}
			catch (InvocationTargetException e)
			{
				e.printStackTrace();					
			}
		}		
		
		return (matrix);
	}
	
	/**
	 * use "" instead of null
	 * 
	 * @param matrix
	 * @return
	 */
	public static String[][] mergeMatrix(String[][] matrix)
	{		
		if (matrix != null)
		{
			int row_num = matrix.length;
			int col_num = matrix[0].length;
			
			for (int row = row_num-1; row >=0; row--)
				for (int col = col_num-1; col >=0; col--)
				{
					if (row > 0 && col >0)
					{
						if (matrix[row][col].equals(matrix[row][col-1])
							&& matrix[row][col].equals(matrix[row-1][col]))
						{
							
						}
						
					}
					else if (row > 0)
					{
						
					}
					else if (col > 0)
					{
						
					}						
				}
		}
		
		return (matrix);
	}
	/**
	 * 将文本类型的日期，转换为java.sql.Date类型
	 * writer:陈伟
	 * @param date：日�?
	 * @param dateStyle：日期样式，如果传入null，使用默认样式�?
	 * @return java.sql.Date
	 */
	public static java.sql.Date textToDateConvery(String date,String dateStyle){
		Date hakkou_hi = null;
		SimpleDateFormat dateFormat = null;		
		if(date==null || date.equalsIgnoreCase("")){
			return null;
		}
		if(dateStyle == null){
			dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		}else{
			dateFormat = new SimpleDateFormat(dateStyle);
		}
		try {
			date = date.replace('-','/');
			
			hakkou_hi = dateFormat.parse(getFormatDate(date));
		} catch (ParseException e) {
			// TODO 自动生成 catch �?
			e.printStackTrace();
		}
		if(hakkou_hi!=null)
			return new java.sql.Date(hakkou_hi.getTime());
		else
			return null;
	}
	
	/**
	 * date 格式�?�?字符�?
	 * @param date
	 * @param style 格式化样�?默认�? yy/MM/dd hh:mm:ss
	 * @return
	 */
	public static String dateToStringConvery(Date date, String style)
	{
		if(date == null)
			return null;
		
		String result = null;
		Format format = null;
		String tmp = null;
		if(style == null)
			tmp = "yy/MM/dd HH:mm:ss";
		else
			tmp = style;
		
		format = new SimpleDateFormat(tmp);
		
		result = format.format(date);
		
		return result;
	}
	
	/**
	 * 将发行日格式化成版下id-发行日格�?
	 * @param date
	 * @return
	 */
	public static String formatDateForHsiddy(String date){
		if(date==null || date.equalsIgnoreCase(""))
			return date;
		date = date.replace('-','/');
		date = getFormatDate(date);
		String str[] = date.split("/");
		if(str.length==3){
			return str[0].substring(2,4)+str[1]+str[2];
		}else{
			return date;
		}
	}	
	private static String getFormatDate(String date){
		String[] temp = null;
		temp = date.split("/");
		if(temp[0].length()==2){
			temp[0] = "20"+temp[0];
		}
		if(temp[1].length()==1){
			temp[1] = "0"+temp[1];
		}
		if(temp[2].length()==1){
			temp[2] = "0"+temp[2];
		}
		return (temp[0]+"/"+temp[1]+"/"+temp[2]);
	}
	/**
	 * 设定Long值的默认�?
	 * @param str
	 * @return
	 */
	public static Long stringToLongConvery(String str){
		if(str==null || str.trim().equalsIgnoreCase("")){
			return Long.parseLong("0");
		}else{
			return Long.parseLong(str);
		}
	}	
	/**
	 * 
	 * @param str
	 * @return
	 */
	public static Long stringToObjectConvery(String str,Object clazz){
		if(str==null || str.trim().equalsIgnoreCase("")){
			return null;
		}else{
			if(clazz instanceof Long)
				return Long.parseLong(str);
			else 
				return null;
		}
	}
	/**
	 * 设定字符串类型默认�?
	 * @param str
	 * @return
	 */
	public static String stringConvery(String str){
		if(str==null || str.trim().equalsIgnoreCase("")){
			return "";
		}else{
			return str;
		}
	}
	/**
	 * 将数组类型转换为字符�?
	 * @param list
	 * @return
	 */
	public static String arrayListConveryToString(List list){
		StringBuffer buffer = new StringBuffer();
		if(list==null || list.isEmpty()){
			return "";
		}else{
			for(int i=0;i<list.size();i++){
				if(i==0){
					buffer.append((String)list.get(i));
				}else{
					buffer.append(",");
					buffer.append((String)list.get(i));
				}
			}
			return buffer.toString();
		}
	}
	/**
	 * 获取指定符号之间的内�?
	 * @param str
	 * @param startFlag
	 * @param endFlag
	 * @return
	 */
	public static String getStringBetweenFlag(String str,String startFlag,String endFlag){
		int start = str.indexOf(startFlag);
		int end = str.indexOf(endFlag);
		
		return str.substring(start+startFlag.length(), end);
	}
	/**
	 * 将字符串日期格式化想显示的格�?
	 * @param date 日期字符�?
	 * @param dateStyle 日期的原始格式（默认为yyMMdd�?
	 * @param showStyle 日期的期望显示格式（默认为yy/MM/dd�?
	 * @return
	 */
	public static String formatDateStyle(String date,String dateStyle,String showStyle){		
		SimpleDateFormat dateFormat = null;
		SimpleDateFormat showDateFormat = null;
		if(date==null || date.equalsIgnoreCase("")){
			return null;
		}
		if(dateStyle == null){
			dateFormat = new SimpleDateFormat("yyMMdd");
		}else{
			dateFormat = new SimpleDateFormat(dateStyle);
		}
		if(showStyle == null){ 
			showDateFormat = new SimpleDateFormat("yy/MM/dd");
		}else{
			showDateFormat = new SimpleDateFormat(showStyle);
		}
		
		try {
			return 	showDateFormat.format(dateFormat.parse(date));
		} catch (Exception e) {
			// TODO 自动生成 catch �?
			e.printStackTrace();
		}
		return null;	
	}
	/**
	 * 格式化浮点数表示格式
	 * @param value
	 * @param pattern
	 * @return
	 */
	public static String formatDouble(double value ,String pattern){
		if(pattern == null || pattern.equalsIgnoreCase("")){
			pattern = "###,###,###,###,###,###";
		}
		DecimalFormat format = new DecimalFormat(pattern);
		return format.format(value);
	}
	/**
	 * 自动用指定字符填充字符传（版下ID�?�?
	 * @param addChar：追加字�?
	 * @param str：字符串
	 * @param addLength：有效长�?
	 * @return
	 */
	public static String formatString(char addChar,String str,int addLength){
		StringBuffer buffer = new StringBuffer();
		if(str==null)
			return str;
		if(str.length()>=addLength){
			return str;
		}else{
			for(int i=0;i<addLength-str.length();i++){
				buffer.append(addChar);
			}
			buffer.append(str);
		}
		return buffer.toString();
	}
	/**
	 * 格式化oracle中所抛出的异常信�?
	 * @param errorMessage
	 * @return
	 */
	public static String formatExceptionMessage(String errorMessage){
		StringBuffer buffer = new StringBuffer();
		if(errorMessage==null || errorMessage.equalsIgnoreCase("")){
			return "";
		}else{
			errorMessage = errorMessage.replace('"','#');
			errorMessage = errorMessage.replace('\'','#');
			errorMessage = errorMessage.replaceAll("#","");
			String[] tempStr = errorMessage.split("\n");
			if(tempStr!=null && tempStr.length>0){
				for(int i=0;i<tempStr.length;i++){
					buffer.append("\\n");
					buffer.append(tempStr[i]);
				}
			}
			return buffer.toString();
		}
			
	}
	//此方法为废方�?修正为valueTransform 直接修改此方法导致TD中调用此方法的�?直接显示出转义字�?
	public static String showValueInPage(Object obj){
		if(obj==null){
			return "";
		}else{
			if(obj instanceof String){
				String s = ((String)obj);
				s = ((String)obj).replaceAll("'", "&#39");
				s = ((String)obj).replaceAll("&", "&amp;");
				s = ((String)obj).replaceAll("<", "&lt;");
				s = ((String)obj).replaceAll(">", "&gt;");
				s = ((String)obj).replaceAll("\"", "&quot;"); 
				return s;
			}else if(obj instanceof Integer){
				return ((Integer)obj).toString();
			}else if(obj instanceof Long){
				return ((Long)obj).toString();
			}else if(obj instanceof Double){
				return ((Double)obj).toString();
			}else if(obj instanceof java.sql.Timestamp){
				return ((java.sql.Timestamp)obj).toString();
			}else if(obj instanceof java.sql.Date){
				return ((java.sql.Date)obj).toString();
			}else{
				return "error";
			}
		}
	}
//	add by zhangxiufeng 071129
	public static String valueTransform(Object obj){
		if(obj==null){
			return "";
		}else{
			if(obj instanceof String){
				String s = ((String)obj);
				s = s.replaceAll("'", "&#39");
				s = s.replaceAll("&", "&amp;");
				s = s.replaceAll("<", "&lt;");
				s = s.replaceAll(">", "&gt;");
				s = s.replaceAll("\"","&quot;"); 
				return s;
			}else if(obj instanceof Integer){
				return ((Integer)obj).toString();
			}else if(obj instanceof Long){
				return ((Long)obj).toString();
			}else if(obj instanceof Double){
				return ((Double)obj).toString();
			}else if(obj instanceof java.sql.Timestamp){
				return ((java.sql.Timestamp)obj).toString();
			}else if(obj instanceof java.sql.Date){
				return ((java.sql.Date)obj).toString();
			}else{
				return "error";
			}
		}
	}
	
	/**
	 * yyq
	 * 将单个或多个小框ID加上引号
	 * @param wakuIds
	 * @return wakuIds
	 */
	public static String WakuIDToQutoMark(String wakuIds)
	{
		String tempWakuInfo = "";
		if(wakuIds != null && !"".equals(wakuIds))
		{
			String[] wakuIdArray = wakuIds.split(",");
			
			int wakuid_len = wakuIdArray.length;
	
			for(int i = 0; i < wakuid_len; i++)
			{
				if("".equals(tempWakuInfo))
				{
					tempWakuInfo = "'" + wakuIdArray[i] + "'";
				}
				else
				{
					tempWakuInfo += "," + "'" + wakuIdArray[i] + "'";
				}
			}		
		}
		return tempWakuInfo;
	}
	public static void main(String[] args){
		String str = "090724";
		System.out.println(MiscUtil.formatExceptionMessage("aaaaaaaaaaaaaaa\"\"aaaa"));
	}
}
