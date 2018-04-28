package employee;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@(DESCRIPTION ="
							+ "(ADDRESS = (PROTOCOL = TCP)(HOST = TRSR)(PORT = 1521))"
							+ "(CONNECT_DATA =" + "(SERVER = DEDICATED)" + "(SERVICE_NAME = XE)" + ")" + ")",
					"sample", "sample");
			return conn;
		} catch (Exception e2) {
			System.out.println("Error at Line # " + e2.getStackTrace()[0].getLineNumber());
			e2.printStackTrace();
		}
		return null;
	}

}
