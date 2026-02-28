
package com.faang.ai;

import okhttp3.*;
import org.json.JSONObject;

public class OllamaClient {

public static String generate(String prompt)throws Exception{

OkHttpClient client=new OkHttpClient();

JSONObject json=new JSONObject();

json.put("model","mistral");

json.put("prompt",prompt);

json.put("stream",false);

Request request=new Request.Builder()
.url("http://localhost:11434/api/generate")
.post(RequestBody.create(
json.toString(),
MediaType.parse("application/json")))
.build();

Response response=client.newCall(request).execute();

return new JSONObject(response.body().string())
.getString("response");

}

}
