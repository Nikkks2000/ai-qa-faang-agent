
package com.faang.ai;

import org.testng.annotations.Test;

public class TestRunner {

@Test
public void run()throws Exception{

String test=OllamaClient.generate(
"Generate simple GET API test JSON");

System.out.println(test);

}

}
