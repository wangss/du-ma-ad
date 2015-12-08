package com.taoren.admin.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParser;

/**
 * Created by wangshuisheng on 2015/9/28.
 */
public class GsonUtil {

    static Gson gson3 = new GsonBuilder().setPrettyPrinting().create();

    static JsonParser jp = new JsonParser();
    public static String prettyString(String json){

        return gson3.toJson(jp.parse(json));
    }

    public static void main(String[] args) {
        String str= "{\"stuNo\":12,\"sex\":1,\"name\":\"carya\"}";

        System.out.println(GsonUtil.prettyString(str));
    }
}
