
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

@RestController
public class test {

    @GetMapping("/runPythonScript")
    public String runPythonScript() {
        try {
            // 파이썬 스크립트 경로
            String pythonScriptPath = "C:\\Users\\KOSA\\Desktop\\pytest\\seleinum.py";

            // 파이썬 실행 명령어 준비
            String[] command = {"python", pythonScriptPath,"netflix","netflix"};

            // 프로세스 빌더 생성
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            
         // 인코딩 설정 추가 (UTF-8)
            processBuilder.redirectErrorStream(true);
            processBuilder.environment().put("PYTHONIOENCODING", "UTF-8");
            

            // 프로세스 실행
            Process process = processBuilder.start();

            // 프로세스의 출력을 읽기 위한 InputStream 설정
            InputStream inputStream = process.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

            // 출력을 문자열로 변환하여 읽어오기
            String jsonOutput = reader.lines().collect(Collectors.joining("\n"));

            // 프로세스가 완료될 때까지 대기
            int exitCode = process.waitFor();

            // 프로세스 종료 코드 확인
            if (exitCode == 0) {
                return "Python script executed successfully. Output:\n" + jsonOutput;
            } else {
                return "Error: Python script execution failed with exit code " + exitCode;
            }

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return "Error: Exception occurred during Python script execution.";
        }
    }
}
