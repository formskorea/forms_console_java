package com.formskorea.console.service

import com.formskorea.console.data.model.CountWork
import com.formskorea.console.data.model.Search
import com.formskorea.console.mapper.console.AdminMapper
import com.formskorea.console.mapper.log.WorkCountMapper
import com.formskorea.console.util.Etc
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.*
import kotlin.collections.ArrayList

@Autowired
lateinit var workCountMapper: WorkCountMapper

@Autowired
lateinit var adminMapper: AdminMapper

@Service
class CountService {
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
                val nowsearch = Search()
                nowsearch.date = nowcount.dateDay
                nowsearch.mtype = 1
                nowcount.intInstagram = adminMapper.getMWorkCount(nowsearch)
                nowsearch.mtype = 2
                nowcount.intYoutube = adminMapper.getMWorkCount(nowsearch)
                nowsearch.mtype = 3
                nowcount.intBlog = adminMapper.getMWorkCount(nowsearch)

                rtnValue.add(nowcount)
            }
        }
        return rtnValue
    }

}