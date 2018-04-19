package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
 /*JSP���� ȸ�������ͺ��̽����̺� ������ �� �ֵ��� DAO�� ����������.
 DAO = �����ͺ��̽����ٰ�ü�� ����. ���������� �����ͺ��̽����� ȸ�������� �ҷ����ų� �ְ����� �� ���
 DAO class ���� ���� ������ DATA BASE�� �����ؼ� � �����͸� �������ų� �����͸� �ִ� ������ �ϴ� ������ ���� ��ü  */
public class UserDAO {

	private Connection conn; 
	/*Ŀ�ؼ��� �����ͺ��̽��� �����ϰ� ���ִ� �ϳ��� ��ü*/
	private PreparedStatement pstmt;
	private ResultSet rs;
	/*��� ������ ���� �� �ִ� �ϳ��� ��ü*/
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			/*localhost�� ������ǻ�� �ּ�. 3306��Ʈ�� �츮 ��ǻ�Ϳ� ��ġ�� mySQL���� ��ü�� �ǹ�. BBS��� �����ͺ��̽��� ����.*/
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			/*Driver�� mySQL�� ������ �� �ֵ��� �Ű�ü ������ ���ִ� �ϳ��� ���̺귯��*/
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*try-catch ������ �̿��ؼ� ����ó���� ����. �����߻��ϸ� ������ ���� print�� �̿��ؼ� ���*/
		/*������ �Ϸᰡ �Ǹ� conn ��ü �ȿ� ������ ���� �ǰ� �̺κе��� ������ mySQL�� ������ �� �ֵ��� ����.*/ 
	}
	 /*-> �����ڸ� ����. User DAO�� �ϳ��� ��ü�� ��������� �ڵ����� DATABASE Ŀ�ؼ��� �̷���� �� �ֵ��� ���ش�.*/
	
	public int login(String userID, String userPassword) { /*������ �α����� �õ��ϴ� �ϳ��� �Լ�*/
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; /*������ ������ ���̽��� �Է��� ��ɾ SQL�������� �������*/
		try {
			pstmt = conn.prepareStatement(SQL); /*pstmt�� preparedstatement ������. pstmt�� ��� ������ SQL ���带 �����͵��̽��� �����ϴ� �������� �� ���Ͻ��� ������.*/  
			pstmt.setString(1, userID); /*�����߿��� �κ�. �⺻���� SQL �����ǰ��� ��ŷ����� ����ϱ� ���� ����. */
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) { /*������ �õ��� ����� ���� USER �н����带 �޾Ƽ� �̰� ������ �õ��� �����н������ �����ϴٸ� �α��� ����(��ȯ�� 1)*/
					return 1; //�α��μ���
				} 
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1;  //���̵� ����
		} catch (Exception e) {
			e.printStackTrace(); /*�ش� ���� ���*/
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(User user) { /*�Ѹ��� ����ڸ� �Է� ���� �� �ֵ��� ��, �̰��� user Ŭ������ �̿��ؼ� ���� �� �ִ� �ϳ��� �ν��Ͻ�*/
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL); /*Statement�� �ν��Ͻ��� �־���*/
			pstmt.setString(1, user.getUserID()); /*���� ����ǥ�� �ش��ϴ� ������ �־���*/
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); /*�ش� statement�� ������ �� ����� ���� �� �ֵ��� ��.*/
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ���� 
		/*�μ�Ʈ ������ ������ ����� �ݵ�� 0�̻��� ���ڰ� ��ȯ�Ǳ� ������ -1�� �ƴ� ���� ���������� ȸ������.*/
	}
}
