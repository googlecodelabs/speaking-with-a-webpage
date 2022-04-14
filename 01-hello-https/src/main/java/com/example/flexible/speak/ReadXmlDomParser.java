package com.example.flexible.speak;


import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;


public class ReadXmlDomParser {

    private String filename = "assignment.xml";
    ArrayList<String> questionList = new ArrayList<>();
    ArrayList<String> answerList = new ArrayList<>();

    public void setFilepath(String filename){
        URL resource = this.getClass().getClassLoader().getResource(filename);
        this.filename = resource.getPath();
    }

    public ReadXmlDomParser( ) {
        setFilepath(this.filename);
        parseQuestionsFromXML(this.filename);
    }

    public ReadXmlDomParser(String filename) {

        setFilepath(filename);
        parseQuestionsFromXML(this.filename);

    }

    public ArrayList<String> getQuestionList() {
        return questionList;
    }

    public ArrayList<String> getAnswerList() {
        return answerList;
    }


    public void parseQuestionsFromXML(String xmlFilePath) {

        // Instantiate the Factory
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

        try {

            // optional, but recommended
            // process XML securely, avoid attacks like XML External Entities (XXE)
            dbf.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

            // parse XML file
            DocumentBuilder db = dbf.newDocumentBuilder();

            Document doc = db.parse(new File(xmlFilePath));

            // optional, but recommended
            doc.getDocumentElement().normalize();

            //System.out.println("Root Element :" + doc.getDocumentElement().getNodeName());

            // get <questions>
            NodeList list = doc.getElementsByTagName("questions");

            for (int temp = 0; temp < list.getLength(); temp++) {

                Node node = list.item(temp);

                if (node.getNodeType() == Node.ELEMENT_NODE) {

                    Element element = (Element) node;

                    // get staff's attribute
                    int id = temp+1;

                    // get text
                    String question = element.getElementsByTagName("question").item(0).getTextContent();
                    String answer = element.getElementsByTagName("answer").item(0).getTextContent();

                    questionList.add(question);
                    answerList.add(answer);
                }
            }

        } catch (ParserConfigurationException | SAXException | IOException e) {
            e.printStackTrace();
        }

    }

}