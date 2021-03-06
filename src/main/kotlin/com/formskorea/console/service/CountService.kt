package com.formskorea.console.service

import com.formskorea.console.data.model.*
import com.formskorea.console.mapper.console.AdminMapper
import com.formskorea.console.mapper.log.WorkCountMapper
import com.formskorea.console.util.Etc
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.*
import kotlin.collections.ArrayList

@Service
class CountService {

    @Autowired
    lateinit var workCountMapper: WorkCountMapper

    @Autowired
    lateinit var adminMapper: AdminMapper

    var log = LoggerFactory.getLogger(this::class.java) as Logger

    fun getCountWork(search: Search): ArrayList<CountWork> {
        var rtnValue = ArrayList<CountWork>()

        val nowdate = Etc.setStringtoDate(Etc.setDatetoString(Date(), "yyyy-MM-dd"), "yyyy-MM-dd")
        var start = if (search.start.isNullOrEmpty()) {
            nowdate
        } else {
            Etc.setStringtoDate(search.start.toString().take(10), "yyyy-MM-dd")
        }
        var end = if (search.end.isNullOrEmpty()) {
            nowdate
        } else {
            Etc.setStringtoDate(search.end.toString().take(10), "yyyy-MM-dd")
        }

        if (start.time <= end.time) {
            if (end.time > nowdate.time) {
                end = nowdate
            }

            val nowcount = CountWork()
            nowcount.dateDay = Etc.setDatetoString(nowdate, "yyyy-MM-dd")

            search.end = Etc.setDatetoString(Etc.setDateAdd(Calendar.DAY_OF_MONTH, -1, end), "yyyy-MM-dd")
            rtnValue = workCountMapper.getWorkCount(search)

            if (end.time >= nowdate.time) {
                rtnValue.add(getCountWorkNow())
            }
        }
        return rtnValue
    }

    fun getCountWorkNow(): CountWork {
        val nowcount = CountWork()
        nowcount.dateDay = Etc.setDatetoString(Date(), "yyyy-MM-dd")

        val nowsearch = Search()
        nowsearch.date = nowcount.dateDay
        nowsearch.mtype = 1
        nowsearch.status = 1
        nowcount.intInstagram = adminMapper.getDHWorkCount(nowsearch)
        nowsearch.mtype = 2
        nowcount.intYoutube = adminMapper.getDHWorkCount(nowsearch)
        nowsearch.mtype = 3
        nowcount.intBlog = adminMapper.getDHWorkCount(nowsearch)
        nowcount.intWork = adminMapper.getMWorkCount(nowsearch)

        return nowcount
    }

    fun setCountWork(data: CountWork) : Boolean {
        return workCountMapper.setWorkCount(data)
    }

    fun getCountUsers(search: Search): ArrayList<CountUsers> {
        var rtnValue = ArrayList<CountUsers>()

        val nowdate = Etc.setStringtoDate(Etc.setDatetoString(Date(), "yyyy-MM-dd"), "yyyy-MM-dd")
        var start = if (search.start.isNullOrEmpty()) {
            nowdate
        } else {
            Etc.setStringtoDate(search.start.toString().take(10), "yyyy-MM-dd")
        }
        var end = if (search.end.isNullOrEmpty()) {
            nowdate
        } else {
            Etc.setStringtoDate(search.end.toString().take(10), "yyyy-MM-dd")
        }

        if (start.time <= end.time) {
            if (end.time > nowdate.time) {
                end = nowdate
            }

            val nowcount = CountWork()
            nowcount.dateDay = Etc.setDatetoString(nowdate, "yyyy-MM-dd")

            search.end = Etc.setDatetoString(Etc.setDateAdd(Calendar.DAY_OF_MONTH, -1, end), "yyyy-MM-dd")
            rtnValue = workCountMapper.getUserCount(search)

            if (end.time >= nowdate.time) {
                rtnValue.add(getCountUsersNow())
            }
        }

        return rtnValue
    }

    fun getCountUsersNow(): CountUsers {
        val nowcount = CountUsers()
        nowcount.dateDay = Etc.setDatetoString(Date(), "yyyy-MM-dd")

        val nowsearch = Search()
        nowsearch.date = nowcount.dateDay
        nowsearch.mtype = 1
        nowsearch.status = 1

        nowcount.intInfluencer = adminMapper.getMInfluncerCount(nowsearch)
        nowcount.intClient = adminMapper.getMClientCount(nowsearch)

        return nowcount
    }

    fun setUserWork(data: CountUsers) : Boolean {
        return workCountMapper.setUserCount(data)
    }

    fun setHistory(data: History) : Boolean {
        return workCountMapper.setHistory(data)
    }

    fun getHistory(data: History) : ArrayList<History> {
        return workCountMapper.getHistory(data)
    }

    fun createWorkLog(data: Work) : Boolean {
        val result1 = workCountMapper.createWorkLog(data)
        val result2 = workCountMapper.createWorkIdx(data)
        val result3 = workCountMapper.createWorkIdx2(data)
        val result4 = workCountMapper.createWorkIdx3(data)
        return result1 && result2 && result3 && result4
    }

    fun getWorkLog(data: Search) : ArrayList<WorkLog> {
        return workCountMapper.getWorkLog(data)
    }

}