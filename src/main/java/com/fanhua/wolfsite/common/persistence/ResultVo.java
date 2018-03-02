package com.fanhua.wolfsite.common.persistence;

import java.util.HashMap;
import java.util.Map;

/**
 * 〈一句话功能简述〉<br>
 * 〈结果视图〉
 * Created by huangdk on 2018/1/15.
 *
 * @version V1.0
 */
public class ResultVo extends HashMap<String, Object> {
    private static final long serialVersionUID = 1L;

    public ResultVo() {
        put("code", 0);
        put("msg", "操作成功");
    }

    public static ResultVo error() {
        return error(1, "操作失败");
    }

    public static ResultVo error(String msg) {
        return error(500, msg);
    }

    public static ResultVo error(int code, String msg) {
        ResultVo r = new ResultVo();
        r.put("code", code);
        r.put("msg", msg);
        return r;
    }

    public static ResultVo ok(String msg) {
        ResultVo r = new ResultVo();
        r.put("msg", msg);
        return r;
    }

    public static ResultVo ok(Map<String, Object> map) {
        ResultVo r = new ResultVo();
        r.putAll(map);
        return r;
    }

    public static ResultVo ok() {
        return new ResultVo();
    }

    @Override
    public ResultVo put(String key, Object value) {
        super.put(key, value);
        return this;
    }
}
