/*DAO클래스는 데이터접근객체 약자. 
실제로 데이터베이스에 접근해서 어떤 데이터를 빼올 수 잇도록 하는 역할하는 클래스*/
package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; 
	/*커넥션은 데이터베이스에 접근하게 해주는 하나의 객체*/
	/*private PreparedStatement pstmt; -> BbsDAO클래느는 여러개의 함수가 사용되기 때문에 가각 함수끼리 데이터베이스 접근에 있어서 마찰이 일어나지 않도록 이것을 지워줌.*/
	private ResultSet rs;
	/*어떠한 정보를 담을 수 있는 하나의 객체*/
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			/*localhost은 본인컴퓨터 주소. 3306포트는 우리 컴퓨터에 설치된 mySQL서버 자체를 의미. BBS라는 데이터베이스에 접속.*/
			String dbID = "root"; 
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			/*Driver는 mySQL에 접속할 수 있도록 매개체 역할을 해주는 하나의 라이브러리*/
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*try-catch 문구을 이용해서 예외처리를 해줌. 오류발생하면 오류가 뭔지 print를 이용해서 출력*/
		/*접속이 완료가 되면 conn 객체 안에 정보가 담기게 되고 이부분들이 실제로 mySQL에 접속할 수 있도록 해줌.*/ 
	}
	 /*-> 생성자를 만듬. User DAO를 하나의 객체로 만들었을때 자동으로 DATABASE 커넥션이 이루어질 수 있도록 해준다.*/
	
	public String getDate() {
	/*현재의 시간을 가져오는 함수로써, 게시판의 글을 작성할때 현재 서버시간을 넣어줌.*/
		String SQL = "SELECT NOW()"; /*현재의 시간을 가져오는 mySQL의 문장*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*결과과 있는 경우*/
				return rs.getString(1); /*현재의 날짜를 그대로 반영*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류 (빈문자열 반환)
	}
	
	public int getNext() {
			String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; 
			/*게시글 번호 같은경우는 1번 부터 하나씩 늘어나야 되기 때문에 마지막에 쓰인 글을 가져와서 그 글 번호에 +1 한 값이 다음글의 번호가 되게 만들어줌. */
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
				rs = pstmt.executeQuery();
				if (rs.next()) { /*결과과 있는 경우*/
					return rs.getInt(1) + 1; /*나온 결과에 1을 더해서 그 다음 게시글의 번호를 만듬*/
				}
				return 1; // 현재가 첫 번째 게시물인 경우
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류  
		}
	
	public int write(String bbsTitle, String userID, String bbsContent) { /*실제로 글을 작성하는 함수*/
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)"; 
		/*실제로 데이터베이스에 하나의 게시글을 작성해서 넣어줄 필요가 있기에 BBS 테이블안에 6개 인자가 다 들어감. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			/*rs = pstmt.executeQuery(); -> INSERT문구에는 필요가없음*/
			return pstmt.executeUpdate();
			/*INSERT 같은 경우에는 성공적으로 수행하면 0이상의 값을 반환하고 오류인경우는 -1을 반환*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 
	}
	
	/*아래 것들은 데이터베이스에서 글의목록을 가져오는 소스코드들(2개의 함수)*/
	public ArrayList<Bbs> getList(int pageNumber){
	/*특정한 리스트를 담아서 반환*/
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		/* bbsID가 특정한 숫자보다 작을때로 잡고 삭제가 되지 않아서 Available 이 1인 글만 가져옴
		 * * 그 다음 내림차순 가져오고 위에서 10개만 가져옴. */
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		/*Bbs 클래스에서 나오는 인스턴스를 보관할 수 있는 리스트를 만듬.*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			/*물음표에 들어갈 내용들.*/
			rs = pstmt.executeQuery();
			while (rs.next()) { /*결과과 있는 경우*/
				Bbs bbs = new Bbs(); /*bbs라는 하나의 인스턴스를 만듬*/
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs); /*리스트에 해당 인스턴스를 담아서 반환*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;   /*리스트에 해당 인스턴스를 담아서 반환*/
	}
	
	
	public boolean nextPage(int pageNumber) {
	/*페이징 처리를 위해 존재하는 함수 -> 특정한 페이지가 존재하는지 NEXT함수를 이용해서 물어보는 것*/
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			/*물음표에 들어갈 내용들.*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*결과과 있는 경우*/
				return true; /*다음페이지로 넘어갈 수 있다는 것을 알려줌*/
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
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setInt(1, bbsID);
			/*물음표에 들어갈 내용들.*/
			rs = pstmt.executeQuery();
			if (rs.next()) { /*결과과 있는 경우*/
				Bbs bbs = new Bbs(); /*bbs라는 하나의 인스턴스를 만듬*/
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
				/*결과로 나온 각각의 6개 변수를 다 받은다음 그것을 Bbs 인스턴스에 넣어서 그걸 그대로 함수를 불러온 대상에게 반환*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID =?"; 
		/*특정한 아이디에 해당하는 제목과 내용을 바꿔준다는 것. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
			/* 성공적으로 수행하면 0이상의 값을 반환하고 오류인경우는 -1을 반환*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID =?"; 
		/*특정한 아이디에 해당하는 제목과 내용을 바꿔준다는 것. */
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/*현재 연결되는 객체를 이용해서 SQL문장을 실행준비단계로 만듬*/
			pstmt.setInt(1, bbsID); 
			return pstmt.executeUpdate();
			/* 성공적으로 수행하면 0이상의 값을 반환하고 오류인경우는 -1을 반환*//* -> 그 반환값으로 성공했다*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 
	}
}
