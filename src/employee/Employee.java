package employee;

public class Employee {
	public String check;
	public String rid;
	public String empid;
	public String empname;
	public String empphone;
	public String address;
	public String doj;
	
	public Employee() {
	}
	
	public Employee(String check,String rid,String empid,String empname,String empphone,String address,String doj)
	{
		this.check = check;
		this.rid = rid;
		this.empid = empid;
		this.empname = empname;
		this.empphone = empphone;
		this.address = address;
		this.doj = doj;
	}
	
	public String getCheck() {
		return check;
	}

	public String getRid() {
		return rid;
	}

	public String getEmpid() {
		return empid;
	}

	public String getEmpname() {
		return empname;
	}

	public String getEmpphone() {
		return empphone;
	}

	public String getAddress() {
		return address;
	}

	public String getDoj() {
		return doj;
	}
}
