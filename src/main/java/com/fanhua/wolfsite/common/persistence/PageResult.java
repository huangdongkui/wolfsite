package com.fanhua.wolfsite.common.persistence;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * 〈一句话功能简述〉<br>
 * 〈分页返回对象〉
 * Created by huangdk on 2018/1/18.
 *
 * @version V1.0
 */
public class PageResult {
    public long getTotal() {
    	if(rows!=null&&rows.size()>0){
    		total=(long)rows.get(0).get("total");
    	}
    	
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<HashMap> getRows() {
        return rows;
    }

    public void setRows(List<HashMap> data) {
        this.rows = data;
    }

    private long total;
    private List<HashMap> rows;
}
