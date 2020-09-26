package com.weikang.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class BackReport {
    private Integer backReportId;
    private Integer backId;
    @JsonFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date time;
    private Double sum;
    private Back back;

    public BackReport() {
    }

    public Integer getBackReportId() {
        return backReportId;
    }

    public void setBackReportId(Integer backReportId) {
        this.backReportId = backReportId;
    }

    public Integer getBackId() {
        return backId;
    }

    public void setBackId(Integer backId) {
        this.backId = backId;
    }

    public Back getBack() {
        return back;
    }

    public void setBack(Back back) {
        this.back = back;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

}
