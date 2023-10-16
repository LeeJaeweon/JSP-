package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.xml.sax.SAXException;
import java.io.StringReader;
import java.io.PrintWriter;

@WebServlet("/parseXML")
public class ParseXMLServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String xmlData = request.getParameter("xmlData");
        PrintWriter out = response.getWriter();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new InputSource(new StringReader(xmlData)));

            // 여기서는 XML 파싱 결과를 출력하지만 실제로는 안전하지 않은 방법입니다.
            // 이 코드는 XXE 취약점을 시뮬레이션하고 이를 수정해야 합니다.
            out.println("<h2>XML Parsing Result:</h2>");
            out.println("<pre>" + xmlData + "</pre>");
        } catch (Exception e) {
            out.println("<h2>Error:</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}
