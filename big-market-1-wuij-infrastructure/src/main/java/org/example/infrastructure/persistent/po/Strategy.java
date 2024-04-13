package org.example.infrastructure.persistent.po;


import lombok.Data;

import java.util.Date;

@Data
public class Strategy {
    /*自增id*/
    private Long id;

    /*抽奖id*/
    private Long strategyId;

    /*抽奖策略描述*/
    private String strategyDesc;

    /*创建时间*/
    private Date createTime;

    /*策略更新时间*/
    private Date updateTime;
}
