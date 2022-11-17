package com.song.spotifyback.service.impl;


import com.song.spotifyback.repository.MusicRepository;
import com.song.spotifyback.service.MusicService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MusicServiceImpl implements MusicService {
    @Autowired
    private final MusicRepository musicRepository;

//    @Transactional
//    public List<Music> getMusics(){
//        return musicRepository.findAll();
//    }
}
