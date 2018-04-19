package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
 /*JSP에서 회원데이터베이스테이블에 접근할 수 있도록 DAO를 만들어줘야함.
 DAO = 데이터베이스접근객체의 약자. 실질적으로 데이터베이스에서 회원정보를 불러오거나 넣고자할 때 사용
 DAO class 같은 경우는 실제로 DATA BASE에 접근해서 어떤 데이터를 가져오거나 데이터를 넣는 역할을 하는 데이터 접근 객체  */
public class UserDAO {

	private Connection conn; 
	/*커넥션은 데이터베이스에 접근하게 해주는 하나의 객체*/
	private PreparedStatement pstmt;
	private ResultSet rs;
	/*어떠한 정보를 담을 수 있는 하나의 객체*/
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) { /*실제로 로그인을 시도하는 하나의 함수*/
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; /*실제로 데이터 베이스에 입력할 명령어를 SQL문장으로 만들어줌*/
		try {
			pstmt = conn.prepareStatement(SQL); /*pstmt는 preparedstatement 약자임. pstmt에 어떠한 정해진 SQL 문장를 데이터데이스에 삽입하는 형식으로 이 스턴스를 가져옴.*/  
			pstmt.setString(1, userID); /*가장중요한 부분. 기본적인 SQL 인젝션같은 해킹기법을 방어하기 위한 수단. */
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) { /*접속을 시도한 결과로 나온 USER 패스워드를 받아서 이게 접속을 시도한 유저패스워드와 동일하다면 로그인 성공(반환값 1)*/
					return 1; //로그인성공
				} 
				else
					return 0; // 비밀번호 불일치
			}
			return -1;  //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace(); /*해당 예외 출력*/
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) { /*한명의 사용자를 입력 받을 수 있도록 함, 이것은 user 클래스를 이용해서 만들 수 있는 하나의 인스턴스*/
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL); /*Statement의 인스턴스를 넣어줌*/
			pstmt.setString(1, user.getUserID()); /*각각 물음표에 해당하는 내용을 넣어줌*/
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); /*해당 statement를 실행한 그 결과를 넣을 수 있도록 함.*/
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 
		/*인설트 문장을 실행한 결과는 반드시 0이상의 숫자가 반환되기 때문에 -1이 아닌 경우는 성공적으로 회원가입.*/
	}
}
