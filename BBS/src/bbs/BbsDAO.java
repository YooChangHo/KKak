/*DAOŬ������ ���������ٰ�ü ����. 
������ �����ͺ��̽��� �����ؼ� � �����͸� ���� �� �յ��� �ϴ� �����ϴ� Ŭ����*/
package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; 
	/*Ŀ�ؼ��� �����ͺ��̽��� �����ϰ� ���ִ� �ϳ��� ��ü*/
	/*private PreparedStatement pstmt; -> BbsDAOŬ������ �������� �Լ��� ���Ǳ� ������ ���� �Լ����� �����ͺ��̽� ���ٿ� �־ ������ �Ͼ�� �ʵ��� �̰��� ������.*/
	private ResultSet rs;
	/*��� ������ ���� �� �ִ� �ϳ��� ��ü*/
	
	public BbsDAO() {
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
	
	public String getDate() {
	/*������ �ð��� �������� �Լ��ν�, �Խ����� ���� �ۼ��Ҷ� ���� �����ð��� �־���.*/
		String SQL = "SELECT NOW()"; /*������ �ð��� �������� mySQL�� ����*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*����� �ִ� ���*/
				return rs.getString(1); /*������ ��¥�� �״�� �ݿ�*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �����ͺ��̽� ���� (���ڿ� ��ȯ)
	}
	
	public int getNext() {
			String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; 
			/*�Խñ� ��ȣ �������� 1�� ���� �ϳ��� �þ�� �Ǳ� ������ �������� ���� ���� �����ͼ� �� �� ��ȣ�� +1 �� ���� �������� ��ȣ�� �ǰ� �������. */
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
				rs = pstmt.executeQuery();
				if (rs.next()) { /*����� �ִ� ���*/
					return rs.getInt(1) + 1; /*���� ����� 1�� ���ؼ� �� ���� �Խñ��� ��ȣ�� ����*/
				}
				return 1; // ���簡 ù ��° �Խù��� ���
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // �����ͺ��̽� ����  
		}
	
	public int write(String bbsTitle, String userID, String bbsContent) { /*������ ���� �ۼ��ϴ� �Լ�*/
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; 
		/*������ �����ͺ��̽��� �ϳ��� �Խñ��� �ۼ��ؼ� �־��� �ʿ䰡 �ֱ⿡ BBS ���̺�ȿ� 6�� ���ڰ� �� ��. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			/*rs = pstmt.executeQuery(); -> INSERT�������� �ʿ䰡����*/
			return pstmt.executeUpdate();
			/*INSERT ���� ��쿡�� ���������� �����ϸ� 0�̻��� ���� ��ȯ�ϰ� �����ΰ��� -1�� ��ȯ*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ���� 
	}
	
	/*�Ʒ� �͵��� �����ͺ��̽����� ���Ǹ���� �������� �ҽ��ڵ��(2���� �Լ�)*/
	public ArrayList<Bbs> getList(int pageNumber){
	/*Ư���� ����Ʈ�� ��Ƽ� ��ȯ*/
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		/* bbsID�� Ư���� ���ں��� �������� ��� ������ ���� �ʾƼ� Available �� 1�� �۸� ������
		 * * �� ���� �������� �������� ������ 10���� ������. */
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		/*Bbs Ŭ�������� ������ �ν��Ͻ��� ������ �� �ִ� ����Ʈ�� ����.*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			/*����ǥ�� �� �����.*/
			rs = pstmt.executeQuery();
			while (rs.next()) { /*����� �ִ� ���*/
				Bbs bbs = new Bbs(); /*bbs��� �ϳ��� �ν��Ͻ��� ����*/
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs); /*����Ʈ�� �ش� �ν��Ͻ��� ��Ƽ� ��ȯ*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;   /*����Ʈ�� �ش� �ν��Ͻ��� ��Ƽ� ��ȯ*/
	}
	
	
	public boolean nextPage(int pageNumber) {
	/*����¡ ó���� ���� �����ϴ� �Լ� -> Ư���� �������� �����ϴ��� NEXT�Լ��� �̿��ؼ� ����� ��*/
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			/*����ǥ�� �� �����.*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*����� �ִ� ���*/
				return true; /*������������ �Ѿ �� �ִٴ� ���� �˷���*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setInt(1, bbsID);
			/*����ǥ�� �� �����.*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*����� �ִ� ���*/
				Bbs bbs = new Bbs(); /*bbs��� �ϳ��� �ν��Ͻ��� ����*/
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
				/*����� ���� ������ 6�� ������ �� �������� �װ��� Bbs �ν��Ͻ��� �־ �װ� �״�� �Լ��� �ҷ��� ��󿡰� ��ȯ*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID =?"; 
		/*Ư���� ���̵� �ش��ϴ� ����� ������ �ٲ��شٴ� ��. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
			/* ���������� �����ϸ� 0�̻��� ���� ��ȯ�ϰ� �����ΰ��� -1�� ��ȯ*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ���� 
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID =?"; 
		/*Ư���� ���̵� �ش��ϴ� ����� ������ �ٲ��شٴ� ��. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*���� ����Ǵ� ��ü�� �̿��ؼ� SQL������ �����غ�ܰ�� ����*/
			pstmt.setInt(1, bbsID); 
			return pstmt.executeUpdate();
			/* ���������� �����ϸ� 0�̻��� ���� ��ȯ�ϰ� �����ΰ��� -1�� ��ȯ*//* -> �� ��ȯ������ �����ߴ�*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ���� 
	}
}
