using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
/// <summary>
/// Summary description for DataConnection
/// </summary>
public class DataConnection
{
    public static bool new_message = false;
    private SqlConnection conn= new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);
    private SqlCommand com;
    private SqlDataReader dr;

    public void connect_db()
    {
        conn.Open();
    }

    public int execute_insert_query(String ins_query)
    {
        try
        {
            com = new SqlCommand(ins_query, conn);
            return com.ExecuteNonQuery();
        }
        catch (Exception ee)
        {
            return 0;
        }
    }
    public string execute_insert_query2(String ins_query)
    {
        try
        {
            com = new SqlCommand(ins_query, conn);
            return ""+com.ExecuteNonQuery();
        }
        catch (Exception ee)
        {
            return ee.Message+" "+ins_query;
        }
    }
    public SqlDataReader execute_select_query(String sel_query)
    {
        try
        {
            com = new SqlCommand(sel_query, conn);
            dr = com.ExecuteReader();
            return dr;
        }
        catch (Exception ee)
        {
            return null;
        }
    }
    public String execute_select_query2(String sel_query)
    {
        try
        {
            com = new SqlCommand(sel_query, conn);
            dr = com.ExecuteReader();
            return "sucess";
        }
        catch (Exception ee)
        {
            return ee.Message;
        }
    }
    public bool execute_update_query(String upd_query)
    {
        try
        {
            com = new SqlCommand(upd_query, conn);
            com.ExecuteNonQuery();
            return true;
        }
        catch (Exception ee)
        {
            return false;
        }
    }
    public string execute_update_query2(String upd_query)
    {
        try
        {
            com = new SqlCommand(upd_query, conn);
            com.ExecuteNonQuery();
            return "true";
        }
        catch (Exception ee)
        {
            return ee.Message;
        }
    }
    public void close_connection()
    {
        if(conn!=null)
        conn.Close();
    }
        
}