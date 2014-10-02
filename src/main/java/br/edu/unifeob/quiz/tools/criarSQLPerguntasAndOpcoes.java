package br.edu.unifeob.quiz.tools;

import java.io.InputStream;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class criarSQLPerguntasAndOpcoes {

	static int perguntaId = 13;
	static int opcaoId = 37;
	

	public static void main(String[] args) throws Exception {
		
		InputStream in = criarSQLPerguntasAndOpcoes.class.getResourceAsStream("/UNIVERSO_UNIFEOB.xlsx");
		
		XSSFWorkbook workbook = new XSSFWorkbook(in);
		
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		Iterator<Row> rowIterator = sheet.iterator();
		
		//pula primeira linha
		if (rowIterator.hasNext()) rowIterator.next();
		
		StringBuilder perguntaValues = new StringBuilder();
		StringBuilder opcoesValues = new StringBuilder();
		
		while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            
            Cell cell = row.getCell(0);
            
            if (perguntaValues.length() > 0) perguntaValues.append(",\n");
            
            perguntaValues.append("(");
            perguntaValues.append(perguntaId);
            perguntaValues.append(",");
            perguntaValues.append("'");
            perguntaValues.append(cell.getStringCellValue());//new String(cell.getStringCellValue().getBytes(Charset.forName("iso-8859-1"))));
            perguntaValues.append("'");
            perguntaValues.append(")");
            
            if (opcoesValues.length() > 0) opcoesValues.append(",\n");
            
            opcoesValues.append(parseOpcoes(perguntaId++, row));
        }
		
		in.close();
		
		//System.out.println("INSERT INTO `perguntas` (`id`, `descricao`) VALUES");
		System.out.println(perguntaValues);

		System.out.println();
		
		//System.out.println("INSERT INTO `opcoes_resposta` (`id`, `correta`, `descricao`, `pergunta_id`) VALUES");
		System.out.println(opcoesValues);
	}
	
	private static String parseOpcoes(int perguntaId, Row row) {
		StringBuilder opcoesValues = new StringBuilder();
		
		double correta = row.getCell(4).getNumericCellValue();
		
		for (int c=1; c < 4; c++) {
            if (opcoesValues.length() > 0) opcoesValues.append(",\n");
            
            opcoesValues.append("(");
            opcoesValues.append(opcaoId++);
            opcoesValues.append(",");
            opcoesValues.append(correta == c ? "00000001" : "00000000");
            opcoesValues.append(",");
            opcoesValues.append("'");
            
            String value = null;
            
            if (row.getCell(c).getCellType() == Cell.CELL_TYPE_NUMERIC) {
            	value = String.valueOf((int)row.getCell(c).getNumericCellValue()); 
            } else {
            	value = row.getCell(c).getStringCellValue();
            }
            
            opcoesValues.append(value);
            opcoesValues.append("'");
            opcoesValues.append(",");
            opcoesValues.append(perguntaId);
            opcoesValues.append(")");
		}
		
		return opcoesValues.toString();
	}
}